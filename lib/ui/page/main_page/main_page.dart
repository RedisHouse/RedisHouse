
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:split_view/split_view.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseStatefulState<MainPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: SplitView(
        viewMode: SplitViewMode.Horizontal,
        initialWeight: 0.2,
        view1: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: FlatButton(
                  color: Color(0x4E80F7),
                  onPressed: () async {
                    // var box = await Hive.openBox("myBox");
                    var box = Hive.box('myBox');

                    box.put('name', 'David');

                    var name = box.get('name');

                    print('Name: $name');
                  },
                  child: Text("添加连接", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: buildTree(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        view2: Container(
          child: Center(child: Text("View2")),
          color: Colors.blue,
        ),
      ),
    );
  }
  var jsonText = '''
{
  "employee": {
    "name": "sonoo",
    "level": 56,
    "married": true,
    "hobby": null
  },
  "week": [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ]
}
''';

  final TreeController _treeController = TreeController(allNodesExpanded: false);
  /// Builds tree or error message out of the entered content.
  Widget buildTree() {
    try {
      var parsedJson = json.decode(jsonText);
      return TreeView(
        nodes: toTreeNodes(parsedJson),
        treeController: _treeController,
      );
    } on FormatException catch (e) {
      return Text(e.message);
    }
  }

  List<TreeNode> toTreeNodes(dynamic parsedJson) {
    if (parsedJson is Map<String, dynamic>) {
      return parsedJson.keys
          .map((k) => TreeNode(
          content: Text('$k:'), children: toTreeNodes(parsedJson[k])))
          .toList();
    }
    if (parsedJson is List<dynamic>) {
      return parsedJson
          .asMap()
          .map((i, element) => MapEntry(i,
          TreeNode(content: Text('[$i]:'), children: toTreeNodes(element))))
          .values
          .toList();
    }
    return [TreeNode(content: Text(parsedJson.toString()))];
  }

}