

import 'package:flutter/services.dart';
import 'package:redis_house/util/string_util.dart';

class Redis {

  static const _channel = MethodChannel('plugins.redishouse.com/redis-plugin');
  Redis._();
  static Redis instance = Redis._();

  Future<bool> ping(Map connectionInfo) async {
    return _channel.invokeMethod("ping", connectionInfo).then((value) {
      return Future.value(true);
    }).catchError((e) {
      return Future.value(false);
    });
  }

  Future connectTo(Map connectionInfo) {
    return _channel.invokeMethod("connectTo", connectionInfo);
  }

  Future close(String connectionId,) {
    return _channel.invokeMethod("close", {
      "id": connectionId,
    });
  }

  Future createSession(String connectionId, String sessionID) {
    return _channel.invokeMethod("createSession", {
      "id": connectionId,
      "sessionID": sessionID
    });
  }

  Future closeSession(String connectionId, String sessionID) {
    return _channel.invokeMethod("closeSession", {
      "id": connectionId,
      "sessionID": sessionID
    });
  }

  Future execute(String connectionId, String sessionID, String command, {String db = "0",}) {
    return _channel.invokeMethod("do", {
      "id": connectionId,
      "sessionID": sessionID,
      "db": db,
      "command": command
    });
  }

}