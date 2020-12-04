import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:redis_house/util/string_util.dart';
import 'router_handler.dart';

class Routes {
  static const String main = "/";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return Container();
        });
//    router.globalNavigatorKey = GlobalKey<NavigatorState>();
    router.define(main, handler: mainHandler);

  }

  static String withParams(String route, Map params) {
    if(params != null && params.isNotEmpty) {
      String paramStr = "";
      params.forEach((key, value) {
        if(StringUtil.isNotBlank(paramStr)) {
          paramStr += "&";
        }
        paramStr += "${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent('$value')}";
      });
      return "$route?$paramStr";
    }
    return route;
  }

}
