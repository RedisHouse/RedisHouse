
import 'package:flutter/cupertino.dart';

import 'base_page.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> with BasePage {

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: buildUI(context),
    );
  }

}