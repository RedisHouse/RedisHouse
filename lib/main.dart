import 'package:bot_toast/bot_toast.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化路由
  Application.initRouter();
  // 初始化
  await Application.doAsyncInit();
  // 全局异常捕获
  CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatelessWidget {
  final easyLoadingBuilder = EasyLoading.init(builder: BotToastInit());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redis House',
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.main,
      builder: (context, child) {
        return easyLoadingBuilder(context, child);
      },
      theme: ThemeData(
        primaryColor: Color(0XFF1D2033),
        scaffoldBackgroundColor: Color(0XFF14172A),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          caption: TextStyle(
            color: Colors.white
          ),
          headline1: TextStyle(
            color: Colors.white
          ),
          // ListView 中的 ListTile.title
          subtitle1: TextStyle(
            color: Colors.white
          ),
          // Drawer 中的 ListTile.title
          bodyText1: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
      ),
    );
  }
}