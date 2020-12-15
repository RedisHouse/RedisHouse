
import 'package:flutter/material.dart';

class MainPageFrame extends StatelessWidget {

  final Widget topBar;
  final Widget bottomBar;
  final Widget leftBar;
  final Widget rightBar;
  final Widget body;

  MainPageFrame({
    this.topBar,
    this.leftBar,
    @required this.body,
    this.rightBar,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          color: Colors.black38,
          child: topBar,
        ),
        Expanded(child: Row(
          children: [
            Container(
              width: 30,
              color: Colors.black38,
              child: leftBar,
            ),
            Expanded(child: body),
            Container(
              width: 30,
              color: Colors.black38,
              child: rightBar,
            ),
          ],
        )),
        Container(
          height: 30,
          color: Colors.black38,
          child: bottomBar,
        ),
      ],
    );
  }

}