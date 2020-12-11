package redis_plugin

import (
	"context"
	"errors"
	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
	"github.com/go-redis/redis/v8"
	"time"
)

const channelName = "plugins.redishouse.com/redis-plugin"

type RedisPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &RedisPlugin{}

type Connection struct {
	id               string
	name             string
	useSSLTLS        bool
	useSSHTunnel     bool
	useSSHPrivateKey bool
	redisName        string
	redisAddress     string
	redisPort        string
	redisPassword    string
	sshAddress       string
	sshPort          string
	sshUser          string
	sshPrivateKey    string
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
	p.channel.HandleFunc("getError", getErrorFunc)
	p.channel.CatchAllHandleFunc(catchAllTest)
	return nil // no error
}

func connectTo(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	_, ok := connectionsMap[argsMap["id"].(string)]
	if ok {
		return true, nil
	}

	connectionsMap[argsMap["id"].(string)] = redis.NewClient(&redis.Options{
		Addr:     argsMap["redisAddress"].(string) + ":" + argsMap["redisPort"].(string),
		Password: argsMap["redisPassword"].(string), // no password set
		DB:       0,                                 // use default DB
	})
	return true, nil
}

func ping(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	connection := redis.NewClient(&redis.Options{
		Addr:     argsMap["redisAddress"].(string) + ":" + argsMap["redisPort"].(string),
		Password: argsMap["redisPassword"].(string), // no password set
		DB:       0,                                 // use default DB
	})
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
		return false, errors.New("尚未连接！")
	}

	connection := connectionsMap[argsMap["id"].(string)]
	err = connection.Set(ctx, argsMap["key"].(string), argsMap["value"].(string), time.Duration(argsMap["expiration"].(int32))).Err()
	if err != nil {
		return false, err
	}
	return true, nil
}

func do(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})

	_, ok := connectionsMap[argsMap["id"].(string)]
	if !ok {
		return false, errors.New("尚未连接！")
	}
	connection := connectionsMap[argsMap["id"].(string)]

	return connection.Do(ctx, "CONFIG", "GET", "databases").Result()
}

func catchAllTest(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	// return the randomized Method Name
	return method.Method, nil
}

func getErrorFunc(arguments interface{}) (reply interface{}, err error) {
	return nil, plugin.NewError("customErrorCode", errors.New("Some error"))
}
