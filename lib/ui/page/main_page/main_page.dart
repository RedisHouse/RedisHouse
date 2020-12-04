
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        initialWeight: 0.7,
        view1: SplitView(
          viewMode: SplitViewMode.Horizontal,
          view1: Container(
            child: Center(child: Text("View1")),
            color: Colors.red,
          ),
          view2: Container(
            child: Center(child: Text("View2")),
            color: Colors.blue,
          ),
          onWeightChanged: (w) => print("Horizon: $w"),
        ),
        view2: Container(
          child: Center(
            child: Text("View3"),
          ),
          color: Colors.green,
        ),
        viewMode: SplitViewMode.Vertical,
        onWeightChanged: (w) => print("Vertical $w"),
      ),
    );
  }

}