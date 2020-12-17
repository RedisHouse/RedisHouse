
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsolePanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConsolePanelState();
  }
}

class _ConsolePanelState extends State<ConsolePanel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(child: Text("Console", style: TextStyle(fontSize: 50),)),
    );
  }

}