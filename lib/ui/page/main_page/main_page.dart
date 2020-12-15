
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/ui/component/split_view.dart';
import 'package:redis_house/ui/page/main_page/component/main_page_frame.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:redis_house/ui/page/main_page/dialog/connection_new_dialog.dart';
import 'package:sembast/sembast.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseStatefulState<MainPage> {

  FocusNode focusNode = FocusNode();

  @override
  Widget buildUI(BuildContext context) {
    return MainPageFrame(
      topBar: Row(
        children: [
          InkWell(
            onTap: () {
              newConnectionDialog(context);
            },
            hoverColor: Colors.red.withAlpha(128),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link),
                  SizedBox(width: 5,),
                  Text("添加连接")
                ],
              ),
            ),
          ),
          SizedBox(width: 50,),
          InkWell(
            onTap: () {
              BotToast.showText(text: "导入");
            },
            hoverColor: Colors.red.withAlpha(128),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.get_app),
                  SizedBox(width: 5,),
                  Text("导入")
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BotToast.showText(text: "导出");
            },
            hoverColor: Colors.red.withAlpha(128),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.upload_rounded),
                  SizedBox(width: 5,),
                  Text("导出")
                ],
              ),
            ),
          ),
        ],
      ),
      leftBar: BlocConsumer<MainPageBloc, MainPageData>(
        listener: (context, state) {
          if(state.connectionListOpen) {
            focusNode.requestFocus();
          } else {
            focusNode.unfocus();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: InkWell(
                  onTap: () {
                    bool openState = state.connectionListOpen??false;
                    context.read<MainPageBloc>().add(ConnectionListOpenEvent(!openState));
                  },
                  focusNode: focusNode,
                  focusColor: Colors.green,
                  hoverColor: Colors.red.withAlpha(128),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("Connection", style: TextStyle(fontSize: 14),),
                  ),
                ),
              ),
            ],
          );
        }
      ),
      body: BlocBuilder<MainPageBloc, MainPageData>(
        builder: (context, state) {
          return Row(
            children: [
              Offstage(
                offstage: !(state.connectionListOpen??false),
                child: Container(
                  width: 300,
                  color: Colors.black.withAlpha(128),
                  child: connectionList(),
                ),
              ),
              Expanded(child: Container(
                child: Center(child: Text("Redis House.", style: TextStyle(fontSize: 50),)),
              ))
            ],
          );
        }
      ),
      bottomBar: Row(
        children: [
          InkWell(
            onTap: () {
              BotToast.showText(text: "查看日志");
            },
            hoverColor: Colors.red.withAlpha(128),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.file_present, size: 20,),
                  SizedBox(width: 5,),
                  Text("查看日志", style: TextStyle(fontSize: 14),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget connectionList() {
    return StreamBuilder<List<RecordSnapshot<int, Map>>>(
      stream: intMapStoreFactory.store("t_connection").query().onSnapshots(Application.db),
      builder: (context, snap) {
        List<RecordSnapshot<int, Map>> list = snap.data;
        return ListView.builder(
          itemCount: list?.length??0,
          itemBuilder: (context, index) {
            var connection = NewConnectionData.fromJson(list[index].value);
            return GFAccordion(
              title: connection.redisName,
              textStyle: TextStyle(color: Colors.white),
              contentPadding: EdgeInsets.zero,
              // titlePadding: EdgeInsets.zero,
              contentChild: IconButton(icon: Icon(Icons.color_lens), onPressed: (){}),
              contentBackgroundColor: Colors.transparent,
              collapsedTitleBackgroundColor: Colors.transparent,
              expandedTitleBackgroundColor: Colors.transparent,
            );
            return ListTile(
              title: Text(connection.redisName),
              onTap: () async {
                bool pingResult = await Redis.instance.connectTo(connection.toJson());
                BotToast.showText(text: "连接成功");
              },
            );
          },
        );
      },
    );
  }

}