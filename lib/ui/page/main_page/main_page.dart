
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            children: [
              Container(
                width: double.infinity,
                child: FlatButton(
                  color: Color(0x4E80F7),
                  onPressed: () {
                    var box = Hive.box('myBox');

                    box.put('name', 'David');

                    var name = box.get('name');

                    print('Name: $name');
                  },
                  child: Text("添加连接", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
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