
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/new_connection_bloc.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/ui/page/main_page/component/main_page_frame.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:redis_house/ui/page/main_page/dialog/connection_new_dialog.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseStatefulState<MainPage> {

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
                    width: 400,
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
      title: Row(
        children: [
          Expanded(child: Text(connection.redisName, maxLines: 1, overflow: TextOverflow.ellipsis,)),
          InkWell(
            onTap: () async {
              context.read<NewConnectionBloc>().add(EditConnectionEvent(connection));
              newConnectionDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "编辑连接信息",
                child: Icon(Icons.edit),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              context.read<NewConnectionBloc>().add(CopyConnectionEvent(connection));
              newConnectionDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "复制连接信息",
                child: Icon(Icons.copy),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              bool deleteConfirm = await NAlertDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: Text("删除连接"),
                content: Text("确定要删除连接【${connection.redisName}】吗？"),
                actions: <Widget>[
                  FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                    Navigator.pop(context, false);
                  }),
                  FlatButton(child: Text("删除", style: TextStyle(color: Colors.red),),onPressed: () {
                    Navigator.pop(context, true);
                  }),
                ],
              ).show(context);
              if(deleteConfirm??false) {
                var finder = Finder(filter: Filter.equals('id', connection.id), limit: 1);
                await intMapStoreFactory.store("t_connection").delete(Application.db, finder: finder);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Tooltip(
                message: "删除连接",
                child: Icon(Icons.delete),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget opened(NewConnectionData connection, MainPageData mainPageData) {
    var connectionDetail = mainPageData.connectedRedisMap[connection.id];
    return ExpansionTile(
      initiallyExpanded: connectionDetail.expanded??false,
      onExpansionChanged: (expanded) {
        context.read<MainPageBloc>().add(ConnectionExpandEvent(connection.id, expanded));
      },
      title: Row(
        children: [
          Expanded(child: Text(connection.redisName, maxLines: 1, overflow: TextOverflow.ellipsis,)),
          InkWell(
            onTap: () {
              Redis.instance.close(connection.id).then((value) {
                context.read<MainPageBloc>().add(ConnectionCloseEvent(connection.id));
              }).catchError((e) {
                BotToast.showText(text: "断开连接失败！");
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Tooltip(
                message: "断开连接",
                child: Icon(Icons.link_off),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BotToast.showText(text: "服务器信息。");
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "服务器信息",
                child: Icon(Icons.info_outlined),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BotToast.showText(text: "打开控制台。");
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "打开控制台",
                child: Icon(Icons.android_outlined),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              context.read<NewConnectionBloc>().add(EditConnectionEvent(connection));
              newConnectionDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "编辑连接信息",
                child: Icon(Icons.edit),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              context.read<NewConnectionBloc>().add(CopyConnectionEvent(connection));
              newConnectionDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "复制连接信息",
                child: Icon(Icons.copy),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              bool deleteConfirm = await NAlertDialog(
                dialogStyle: DialogStyle(titleDivider: true),
                title: Text("删除连接"),
                content: Text("确定要删除连接【${connection.redisName}】吗？"),
                actions: <Widget>[
                  FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                    Navigator.pop(context, false);
                  }),
                  FlatButton(child: Text("删除", style: TextStyle(color: Colors.red),),onPressed: () {
                    Navigator.pop(context, true);
                  }),
                ],
              ).show(context);
              if(deleteConfirm??false) {
                await Redis.instance.close(connection.id).then((value) {
                  context.read<MainPageBloc>().add(ConnectionCloseEvent(connection.id));
                });
                var finder = Finder(filter: Filter.equals('id', connection.id), limit: 1);
                await intMapStoreFactory.store("t_connection").delete(Application.db, finder: finder);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Tooltip(
                message: "删除连接",
                child: Icon(Icons.delete),
              ),
            ),
          ),
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