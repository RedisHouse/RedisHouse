
import 'dart:io';
import 'package:path/path.dart';

String redisHousePath() {
  return join(homePath(), ".redishouse", "db");
}

String homePath() {
  // String os = Platform.operatingSystem;
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}