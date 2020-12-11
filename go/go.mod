module github.com/RedisHouse/RedisHouse/go

go 1.14

require (
	github.com/RedisHouse/RedisHouse/go-plugins/redis v0.0.0-00010101000000-000000000000
	github.com/go-flutter-desktop/go-flutter v0.42.0
	github.com/go-gl/glfw/v3.3/glfw v0.0.0-20201108214237-06ea97f0c265
	github.com/miguelpruivo/flutter_file_picker/go v0.0.0-20201204233127-fed6a7d8ea59
	github.com/pkg/errors v0.9.1
)

replace github.com/RedisHouse/RedisHouse/go-plugins/redis => ../go-plugins/redis
