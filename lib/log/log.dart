
import 'package:logger/logger.dart';

import 'custom_log_filter.dart';
import 'custom_log_output.dart';

class Log {

  Log._();

  static Logger logger = Logger(
    filter: CustomLogFilter(),
    printer: PrettyPrinter(),
    output: CustomLogOutput(),
    level: Level.debug,
  );

  /// Log a message at level [Level.verbose].
  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.verbose, message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.debug, message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.info, message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.warning, message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.error, message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) {
    logger.log(Level.wtf, message, error, stackTrace);
  }

}