
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
        Offstage(
          offstage: topBar == null,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black38,
              border: Border(bottom: BorderSide(color: Colors.grey.withAlpha(128), width: 0.5))
            ),
            child: topBar,
          ),
        ),
        Expanded(child: Row(
          children: [
            Offstage(
              offstage: leftBar == null,
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  border: Border(right: BorderSide(color: Colors.grey.withAlpha(128), width: 0.5))
                ),
                child: leftBar,
              ),
            ),
            Expanded(child: body),
            Offstage(
              offstage: rightBar == null,
              child: Container(
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border(left: BorderSide(color: Colors.grey.withAlpha(128), width: 0.5))
                ),
                child: rightBar,
              ),
            ),
          ],
        )),
        Offstage(
          offstage: bottomBar == null,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: Colors.black38,
                border: Border(top: BorderSide(color: Colors.grey.withAlpha(128), width: 0.5))
            ),
            child: bottomBar,
          ),
        ),
      ],
    );
  }

}