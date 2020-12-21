package redis_plugin

import (
	"errors"
	"fmt"
	"log"
	"net"
	"strings"
	"time"

	redigo "github.com/garyburd/redigo/redis"
	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "plugins.redishouse.com/redis-plugin"

type RedisPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &RedisPlugin{}
var maxIdle = 100

type Connection struct {
	id                    string
	name                  string
	useSSLTLS             bool
	useSSHTunnel          bool
	useSSHPrivateKey      bool
	redisName             string
	redisAddress          string
	redisPort             string
	redisPassword         string
	sshAddress            string
	sshPassword           string
	sshPort               string
	sshUser               string
	sshPrivateKey         string
	sshPrivateKeyPassword string
}

type Session struct {
	ID   string
	Conn redigo.Conn
}

var poolsMap map[string]*redigo.Pool = make(map[string]*redigo.Pool)
var poolsSessionsMap map[string]map[string]Session = make(map[string]map[string]Session)

func (p *RedisPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {

	p.channel = plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	p.channel.HandleFunc("connectTo", connectTo)
	p.channel.HandleFunc("createSession", createSession)
	p.channel.HandleFunc("closeSession", closeSession)
	p.channel.HandleFunc("ping", ping)
	p.channel.HandleFunc("do", do)
	p.channel.HandleFunc("close", close)
	p.channel.HandleFunc("getError", getErrorFunc)
	p.channel.CatchAllHandleFunc(catchAllTest)
	return nil // no error
}

func connectTo(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; ok {
		return
	}
	if nil != err {
		log.Printf("get ssh client err: %v\n", err)
		return nil, err
	}

	redisAddr := fmt.Sprintf("%s:%s", argsMap["redisAddress"].(string), argsMap["redisPort"].(string))

	var conn net.Conn = nil
	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {

		client, err := getSSHClient(argsMap)
		if err != nil {
			log.Fatal("dial to redis addr err: ", err)
			return nil, err
		}
		conn, err = client.Dial("tcp", redisAddr)
	}

	pool := &redigo.Pool{
		MaxIdle: maxIdle,
		IdleTimeout: 240 * time.Second,
		Dial: func() (redigo.Conn, error) {

			var c redigo.Conn
			if conn != nil {
				c = redigo.NewConn(conn, -1, -1)
			} else {
				c, err = redigo.Dial("tcp", redisAddr)
			}

			if err != nil {
				return nil, err
			}

			if _, ok := argsMap["redisPassword"]; ok && argsMap["redisPassword"].(string) != "" {
				if _, err := c.Do("AUTH", argsMap["redisPassword"].(string)); err != nil {
					c.Close()
					return nil, err
				}
			}

			if _, ok := argsMap["redisDB"]; ok {
				if _, err := c.Do("SELECT", argsMap["redisDB"].(int)); err != nil {
					c.Close()
					return nil, err
				}
			}
			return c, nil
		},
		TestOnBorrow: func(c redigo.Conn, t time.Time) error {
			if time.Since(t) < time.Minute {
				return nil
			}
			_, err := c.Do("PING")
			return err
		},
	}
	redisConn := pool.Get()

	pong, err := redisConn.Do("ping")
	if err != nil || pong.(string) != "PONG" {
		log.Fatal("redis connect failed", err)
		return nil, err
	}
	redisConn.Close()

	poolsMap[argsMap["id"].(string)] = pool
	return
}

func createSession(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; ok {
		return nil, errors.New("sessionID 已存在！")
	}

	pool := poolsMap[argsMap["id"].(string)]
	redisConn := pool.Get()

	sessionsMap[argsMap["sessionID"].(string)] = Session{
		ID:   argsMap["sessionID"].(string),
		Conn: redisConn,
	}
	return nil, nil
}

func closeSession(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; !ok {
		return nil, errors.New("sessionID 不存在！")
	}
	session := sessionsMap[argsMap["sessionID"].(string)]
	session.Conn.Close()
	delete(sessionsMap, argsMap["sessionID"].(string))
	return nil, nil
}

type redError struct {
	ErrCode string
}

func (e *redError) Error() string {
	return e.ErrCode
}

func readReply(ascReply interface{}) (reply interface{}, err error) {

	switch rep := ascReply.(type) {
	default:
		return nil, errors.New("unexpected type")
	case nil:
		return nil, nil
	case redigo.Error:
		return nil, rep
	case int64:
		return redigo.Int64(rep, err)
	case string:
		return redigo.String(rep, err)
	case []byte:
		return redigo.String(rep, err)
	case []interface{}:
		result := make([]interface{}, len(rep))
		for i, v := range rep {
			r, err := readReply(v)
			if err != nil {
				return nil, err
			}
			result[i] = r
		}
		return result, err
	}
	return nil, nil
}

/*
Redis type              Go type
error                   redis.Error
integer                 int64
simple string           string
bulk string             []byte or nil if value not present.
array                   []interface{} or nil if value not present.
*/
func do(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; !ok {
		return nil, errors.New("sessionID 不存在！")
	}

	redisConn := sessionsMap[argsMap["sessionID"].(string)].Conn

	//_, err = redisConn.Do("PING")
	//if err != nil {
	//	pool := poolsMap[argsMap["id"].(string)]
	//	redisConn = pool.Get()
	//	sessionsMap[argsMap["sessionID"].(string)] = Session{
	//		ID:   argsMap["sessionID"].(string),
	//		Conn: redisConn,
	//	}
	//	//err = redisConn.Close()
	//	return nil, err
	//}

	strFields := strings.Fields(argsMap["command"].(string))
	command := strFields[0]
	args := make([]interface{}, len(strFields)-1)
	for i, v := range strFields[1:] {
		args[i] = v
	}

	var res interface{}
	if len(args) == 0 {
		res, err = redisConn.Do(command)
	} else {
		res, err = redisConn.Do(command, args...)
	}
	if err != nil {
		return nil, err
	}

	return readReply(res)
}

func close(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; ok {
		delete(poolsSessionsMap[argsMap["id"].(string)], argsMap["id"].(string))
	}

	if _, ok := poolsMap[argsMap["id"].(string)]; ok {
		pool := poolsMap[argsMap["id"].(string)]
		err = pool.Close()
		if err != nil {
			return nil, err
		}
		delete(poolsMap, argsMap["id"].(string))
	}
	return nil, err
}

func ping(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})

	redisAddr := fmt.Sprintf("%s:%s", argsMap["redisAddress"].(string), argsMap["redisPort"].(string))
	var conn net.Conn = nil
	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {

		client, err := getSSHClient(argsMap)
		defer client.Close()
		if err != nil {
			log.Fatal("dial to redis addr err: ", err)
			return nil, err
		}
		conn, err = client.Dial("tcp", redisAddr)
		defer conn.Close()
	}

	var c redigo.Conn
	if conn != nil {
		c = redigo.NewConn(conn, -1, -1)
	} else {
		c, err = redigo.Dial("tcp", redisAddr)
		if err != nil {
			return nil, err
		}
	}
	defer c.Close()

	if _, ok := argsMap["redisPassword"]; ok && argsMap["redisPassword"].(string) != "" {
		if _, err := c.Do("AUTH", argsMap["redisPassword"].(string)); err != nil {
			return nil, err
		}
	}

	pong, err := c.Do("ping")
	if err != nil || pong.(string) != "PONG" {
		log.Fatal("redis connect failed", err)
		return nil, err
	}
	return
}

func catchAllTest(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	// return the randomized Method Name
	return method.Method, nil
}

func getErrorFunc(arguments interface{}) (reply interface{}, err error) {
	return nil, plugin.NewError("customErrorCode", errors.New("Some error"))
}
