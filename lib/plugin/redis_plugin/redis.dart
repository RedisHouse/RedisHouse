

import 'package:flutter/services.dart';
import 'package:redis_house/util/string_util.dart';

class Redis {

  static const _channel = MethodChannel('plugins.redishouse.com/redis-plugin');
  Redis._();
  static Redis instance = Redis._();

  Future<bool> ping(Map connectionInfo) async {
    return _channel.invokeMethod("ping", connectionInfo).then((value) {
      return Future.value(StringUtil.isEqual("PONG", value));
    }).catchError((e) {
      return Future.value(false);
    });
  }

  Future<bool> connectTo(Map connectionInfo) {
    connectionInfo["id"] = "1";
    return _channel.invokeMethod("connectTo", connectionInfo);
  }

  Future<bool> set(String key, String value) {
    return _channel.invokeMethod("set", {
      "id": "1",
      "key": key,
      "value": value,
      "expiration": 0
    });
  }

  Future<String> get(String key) {
    return _channel.invokeMethod("get", {
      "id": "1",
      "key": key
    });
  }

}