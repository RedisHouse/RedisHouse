import 'package:bot_toast/bot_toast.dart';
import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/new_connection_bloc.dart';
import 'package:redis_house/generated/l10n.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/router/routers.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const platform_channel_redis =
    const MethodChannel('plugins.redishouse.com/redis');

void main() async {

   test('Test redis Plugin result', () async {
    // Invoke a method on the method channel, specifying the concrete
    // method to call via the String identifier.
    final int result =
        await platform_channel_redis.invokeMethod('ping');
    
    final String redisPingResult = '          -- redis ping result: $result % .';
    print(redisPingResult);
  });

  WidgetsFlutterBinding.ensureInitialized();
  // 初始化
  Application.doInit();
  // 初始化-异步
  await Application.doAsyncInit();
  // 全局异常捕获
  // CatcherOptions debugOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  // CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  // Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final easyLoadingBuilder = EasyLoading.init(builder: BotToastInit());
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewConnectionBloc(context, NewConnectionData((b) =>
            b..useSSLTLS=false..useSSHTunnel=false..useSSHPrivateKey=false
          )),
        ),
      ],
      child: MaterialApp(
        title: 'Redis House',
        onGenerateRoute: Application.router.generator,
        initialRoute: Routes.main,
        builder: (context, child) {
          return easyLoadingBuilder(context, child);
        },
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
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
      ),
    );
  }
}