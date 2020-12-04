import 'package:fluro/fluro.dart';
import 'routers.dart';

class Application {

  static FluroRouter router;

  static void initRouter() {
    // 初始化路由
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  static Future doAsyncInit() async {

  }

}
