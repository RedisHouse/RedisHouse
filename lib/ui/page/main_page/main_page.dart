
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:redis_house/ui/page/main_page/dialog/connection_new_dialog.dart';
import 'package:split_view/split_view.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseStatefulState<MainPage> {

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
                  onPressed: () {
                    newConnectionDialog(context);
                  },
                  child: Text("添加连接", style: TextStyle(color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(),
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
}