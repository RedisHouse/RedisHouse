
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/ui/component/split_view.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:redis_house/ui/page/main_page/dialog/connection_new_dialog.dart';

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
        initialWeight: 0.3,
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
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: connectionList(),
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

  Widget connectionList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('connectionList').listenable(),
      builder: (context, box, widget) {
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            var connection = NewConnectionData.fromJson(jsonDecode(box.getAt(index)));
            return ListTile(
              title: Text(connection.redisName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.upload_rounded), onPressed: () async {
                    await Redis.instance.set("name", "渣渣文文");
                  }),
                  IconButton(icon: Icon(Icons.get_app), onPressed: () async {
                    String value = await Redis.instance.get("name");
                    BotToast.showText(text: "name=$value");
                  },),
                  IconButton(icon: Icon(Icons.ac_unit), onPressed: () async {
                    String value = await Redis.instance.execute("CONFIG GET databases");
                    BotToast.showText(text: "$value");
                  },),
                ],
              ),
              onTap: () async {
                bool pingResult = await Redis.instance.connectTo(connection.toJson());
                BotToast.showText(text: "连接结果: $pingResult");
              },
            );
          },
        );
      },
    );
  }

}