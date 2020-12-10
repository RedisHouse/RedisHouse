package redis

import (
	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "plugins.redishouse.com/redis"

type RedisPlugin struct{}

var _ flutter.Plugin = &RedisPlugin{}

func (p *RedisPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {
	channel := plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	channel.HandleFunc("ping", ping)
	return nil // no error
}

func ping(arguments interface{}) (reply interface{}, err error) {
	connected := 111 // Your platform-specific API
	return connected, nil
}
