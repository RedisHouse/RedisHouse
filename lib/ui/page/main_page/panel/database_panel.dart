
import 'package:flutter/material.dart';

class DatabasePanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DatabasePanelState();
  }
}

class _DatabasePanelState extends State<DatabasePanel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(child: Text("Database", style: TextStyle(fontSize: 50),)),
    );
  }

}