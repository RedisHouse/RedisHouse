
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoPanelState();
  }
}

class _InfoPanelState extends State<InfoPanel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text("Redis Info", style: TextStyle(fontSize: 50),)),
    );
  }

}