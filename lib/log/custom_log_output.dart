
import 'package:logger/logger.dart';

typedef CustomOutputCallback = void Function(OutputEvent event);

class CustomLogOutput extends LogOutput {

  static List<CustomOutputCallback> callbacks = [];

  @override
  void output(OutputEvent event) {
    for(CustomOutputCallback item in callbacks) {
      item(event);
    }
    event.lines.forEach(print);
  }

  static void removeOutputListener(callback) {
    if(callbacks != null && callbacks.contains(callback)) {
      callbacks.remove(callback);
    }
  }

  static void addOutputListener(CustomOutputCallback callback) {
    if(callbacks != null && !callbacks.contains(callback)) {
      callbacks.add(callback);
    }
  }



}