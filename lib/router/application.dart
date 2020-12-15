
import 'package:fluro/fluro.dart';
import 'package:hive/hive.dart';
import 'package:redis_house/util/path_util.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast_io.dart';

import 'routers.dart';

class Application {
  static FluroRouter router;
  static sembast.Database db;

  static void doInit() {
    // 初始化路由
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    // 初始化 Hive
    Hive.init(join(redisHousePath(), "hive"));

  }

  static Future doAsyncInit() async {
    db = await databaseFactoryIo.openDatabase(join(redisHousePath(), "sembast", "sembast.db"));
  }
}
