

import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test("UUID 重复检查", () {
    Set<String> uuidSet = Set();
    for(int i = 0; i < 100; i++) {
      uuidSet.add(Uuid().v4());
    }
    print("UUID Set Length: ${uuidSet.length}");

  });
}