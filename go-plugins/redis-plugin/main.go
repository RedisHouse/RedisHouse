package redis_plugin

import (
	"context"
	"errors"
	"log"
	"net"
	"strings"
	"time"

	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-redis/redis/v8"
)

const channelName = "plugins.redishouse.com/redis-plugin"

type RedisPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &RedisPlugin{}

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

var connectionsMap map[string]*redis.Client = make(map[string]*redis.Client)
var ctx = context.Background()

func (p *RedisPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {

	p.channel = plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	p.channel.HandleFunc("connectTo", connectTo)
	p.channel.HandleFunc("ping", ping)
	p.channel.HandleFunc("get", get)
	p.channel.HandleFunc("set", set)
	p.channel.HandleFunc("do", do)
	p.channel.HandleFunc("close", close)
	p.channel.HandleFunc("getError", getErrorFunc)
	p.channel.CatchAllHandleFunc(catchAllTest)
	return nil // no error
}

func connectTo(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := connectionsMap[argsMap["id"].(string)]; ok {
		return
	}
	if nil != err {
		log.Printf("get ssh client err: %v\n", err)
		return nil, err
	}

	option := redis.Options{
		Addr: argsMap["redisAddress"].(string) + ":" + argsMap["redisPort"].(string),
		DB:   0, // use default DB

	}

	if _, ok := argsMap["redisPassword"]; ok {
		option.Password = argsMap["redisPassword"].(string)
	}

	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {
		client, err := getSSHClient(argsMap)

		if err != nil {
			return nil, err
		}
		option.Dialer = func(ctx context.Context, network, addr string) (conn net.Conn, e error) {
			return client.Dial(network, addr)
		}
	}

	connectionsMap[argsMap["id"].(string)] = redis.NewClient(&option)
	return
}

func ping(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	option := redis.Options{
		Addr: argsMap["redisAddress"].(string) + ":" + argsMap["redisPort"].(string),
		DB:   0, // use default DB
	}

	if _, ok := argsMap["redisPassword"]; ok {
		option.Password = argsMap["redisPassword"].(string)
	}

	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {
		client, err := getSSHClient(argsMap)
		if err != nil {
			return nil, err
		}
		option.Dialer = func(ctx context.Context, network, addr string) (conn net.Conn, e error) {
			return client.Dial(network, addr)
		}
	}

	connection := redis.NewClient(&option)

	defer connection.Close()
	return connection.Ping(ctx).Result()
}

func get(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	_, ok := connectionsMap[argsMap["id"].(string)]
	if !ok {
		return nil, errors.New("尚未连接！")
	}

	connection := connectionsMap[argsMap["id"].(string)]
	return connection.Get(ctx, argsMap["key"].(string)).Result()
}

func set(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	_, ok := connectionsMap[argsMap["id"].(string)]
	if !ok {
		return nil, errors.New("尚未连接！")
	}

	connection := connectionsMap[argsMap["id"].(string)]
	return nil, connection.Set(ctx, argsMap["key"].(string), argsMap["value"].(string), time.Duration(argsMap["expiration"].(int32))).Err()
}

func do(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})

	_, ok := connectionsMap[argsMap["id"].(string)]
	if !ok {
		return false, errors.New("尚未连接！")
	}
	connection := connectionsMap[argsMap["id"].(string)]

	strFields := strings.Fields(argsMap["command"].(string))
	commands := make([]interface{}, len(strFields))
	for i, v := range strFields {
		commands[i] = v
	}

	return connection.Do(ctx, commands...).Result()
}

func close(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	_, ok := connectionsMap[argsMap["id"].(string)]
	if !ok {
		return nil, errors.New("尚未连接！")
	}
	connection := connectionsMap[argsMap["id"].(string)]
	err = connection.Close()
	if err == nil {
		delete(connectionsMap, argsMap["id"].(string))
	}
	return nil, err
}

func catchAllTest(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	// return the randomized Method Name
	return method.Method, nil
}

func getErrorFunc(arguments interface{}) (reply interface{}, err error) {
	return nil, plugin.NewError("customErrorCode", errors.New("Some error"))
}
