
import 'package:flutter/cupertino.dart';

import 'base_page.dart';

abstract class BaseStatelessPage extends StatelessWidget with BasePage{

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: buildUI(context),
    );
  }

}