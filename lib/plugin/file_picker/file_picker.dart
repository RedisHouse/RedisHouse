

import 'package:flutter/services.dart';

class FilePicker {

  MethodChannel _channel = MethodChannel('miguelruivo.flutter.plugins.filepicker');

  FilePicker._();

  static FilePicker instance = FilePicker._();

  Future<String> pickFile({
    allowMultipleSelection = false
  }) {
    return _channel.invokeMethod("any", {
      'allowMultipleSelection': allowMultipleSelection,
    });
  }

}