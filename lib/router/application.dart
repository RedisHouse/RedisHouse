import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:redis_house/util/path_util.dart';
import 'routers.dart';

class Application {
  static FluroRouter router;

  static void doInit() {
    // 初始化路由
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    Hive.init(redisHousePath());
  }

  static Future doAsyncInit() async {
    await Hive.openBox("connectionList");
  }
}
