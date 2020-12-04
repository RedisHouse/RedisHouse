
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';

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
      body: Container(color: Colors.red,),
    );
  }

}