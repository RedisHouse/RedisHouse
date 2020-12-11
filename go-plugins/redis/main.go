package redis

import (
	"errors"
	"log"

	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "plugins.redishouse.com/redis"

type RedisPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &RedisPlugin{}

type Connection struct {
	id               int
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

var connectionsMap map[string]Connection = make(map[string]Connection)

func (p *RedisPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	p.channel = plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	p.channel.HandleFunc("ping", ping)
	p.channel.HandleFunc("getError", getErrorFunc)
	p.channel.CatchAllHandleFunc(catchAllTest)
	return nil // no error
}

func connectTo(connection Connection) (reply interface{}, err error) {
	log.Println("InvokeMethod connectTo -------", connection)
	return "connectToReturn", nil
}

func ping(arguments interface{}) (reply interface{}, err error) {
	log.Println("InvokeMethod ping")
	return "PONG", nil
}

func catchAllTest(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	// return the randomized Method Name
	return method.Method, nil
}

func getErrorFunc(arguments interface{}) (reply interface{}, err error) {
	return nil, plugin.NewError("customErrorCode", errors.New("Some error"))
}
