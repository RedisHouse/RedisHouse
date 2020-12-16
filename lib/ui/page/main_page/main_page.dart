
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/router/application.dart';
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

  FocusNode connectionListFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: MainPageFrame(
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
                    Icon(Icons.add),
                    SizedBox(width: 5,),
                    Text("添加连接")
                  ],
                ),
              ),
            ),
            SizedBox(width: 50,),
            Offstage(
              offstage: true,
              child: InkWell(
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
            ),
            Offstage(
              offstage: true,
              child: InkWell(
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
            ),
          ],
        ),
        leftBar: BlocBuilder<MainPageBloc, MainPageData>(
          buildWhen: (previous, current) {
            return previous.redisListOpen != current.redisListOpen;
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  color: state.redisListOpen??false ? Colors.green.withAlpha(128) : Colors.transparent,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: InkWell(
                      onTap: () {
                        bool openState = state.redisListOpen??false;
                        context.read<MainPageBloc>().add(RedisListOpenEvent(!openState));
                      },
                      hoverColor: Colors.red.withAlpha(128),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Redis 列表", style: TextStyle(fontSize: 14),),
                      ),
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
                  offstage: !(state.redisListOpen??false),
                  child: Container(
                    width: 300,
                    color: Colors.black.withAlpha(128),
                    child: connectionList(state),
                  ),
                ),
                Expanded(child: Container(
                  child: Center(child: Text("Redis House.", style: TextStyle(fontSize: 50),)),
                )),
                Offstage(
                  offstage: !(state.logOpen??false),
                  child: Container(
                    width: 300,
                    color: Colors.black.withAlpha(128),
                    child: Center(child: Text("日志", style: TextStyle(fontSize: 50),)),
                  ),
                ),
              ],
            );
          }
        ),
        rightBar: BlocBuilder<MainPageBloc, MainPageData>(
          buildWhen: (previous, current) {
            return previous.logOpen != current.logOpen;
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  color: state.logOpen??false ? Colors.green.withAlpha(128) : Colors.transparent,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: InkWell(
                      onTap: () {
                        bool openState = state.logOpen??false;
                        context.read<MainPageBloc>().add(LogOpenEvent(!openState));
                      },
                      hoverColor: Colors.red.withAlpha(128),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("查看日志", style: TextStyle(fontSize: 14),),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget connectionList(MainPageData mainPageData) {
    return StreamBuilder<List<RecordSnapshot<int, Map>>>(
      stream: intMapStoreFactory.store("t_connection").query().onSnapshots(Application.db),
      builder: (context, snap) {
        List<RecordSnapshot<int, Map>> list = snap.data;
        return ListView.builder(
          itemCount: list?.length??0,
          itemBuilder: (context, index) {
            var connection = NewConnectionData.fromJson(list[index].value);
            var connectionOpened = mainPageData.connectedRedisMap?.containsKey(connection.id)??false;
            return connectionOpened ? opened(connection, mainPageData) : unOpened(connection, mainPageData);
          },
        );
      },
    );
  }

  Widget unOpened(NewConnectionData connection, MainPageData mainPageData) {
    return ListTile(
      onTap: () async {
        Redis.instance.connectTo(connection.toJson()).then((value) {
          return Redis.instance.execute(connection.id, "CONFIG GET databases");
        }).then((value) {
          context.read<MainPageBloc>().add(ConnectionOpenEvent(connection.id, int.tryParse(value[1])));
        }).catchError((e) {
          BotToast.showText(text: "连接出错！");
        });
      },
      title: Text(connection.redisName),
    );
  }

  Widget opened(NewConnectionData connection, MainPageData mainPageData) {
    var connectionDetail = mainPageData.connectedRedisMap[connection.id];
    return ExpansionTile(
      title: Row(
        children: [
          Icon(Icons.check),
          SizedBox(width: 5,),
          Text(connection.redisName),
        ],
      ),
      expandedAlignment: Alignment.topLeft,
      children: connectionDetail != null ? connectionDetail.dbKeyNumMap.map((key, value) {
        return MapEntry(
          key,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.landscape),
                SizedBox(width: 5,),
                Text(key),
              ],
            ),
          ),
        );
      }).values.toList() : [],
    );
  }



}