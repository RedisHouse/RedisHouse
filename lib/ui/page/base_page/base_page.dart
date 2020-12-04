

import 'package:flutter/material.dart';

abstract class BasePage {

  Widget buildUI(BuildContext context);

  Future<bool> onWillPop() async {
    return true;
  }

}