
import 'package:bot_toast/bot_toast.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/new_connection_bloc.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/ui/page/main_page/component/main_page_frame.dart';
import 'package:redis_house/ui/page/base_page/base_stateful_state.dart';
import 'package:redis_house/ui/page/main_page/dialog/connection_new_dialog.dart';
import 'package:redis_house/ui/page/main_page/panel/console_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/database_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/info_panel.dart';
import 'package:redis_house/util/string_util.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseStatefulState<MainPage> with TickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.removeListener(tabChangedListener);
    tabController?.dispose();
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
                Expanded(child: panelContainer()),
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

  Map<String, Widget> panelWidgetMap = Map();
  void tabChangedListener () {
    context.read<MainPageBloc>().add(PanelActiveEvent(tabController.index));
  }

  Widget panelContainer() {
    return BlocBuilder<MainPageBloc, MainPageData>(
      builder: (context, state) {
        if(state.panelList == null || state.panelList.length == 0) {
          return Container(
            child: Center(child: Text("Redis House.", style: TextStyle(fontSize: 50),)),
          );
        }
        var uuidList = state.panelList.map((item) => item.uuid);
        panelWidgetMap.removeWhere((key, value) => !uuidList.contains(key));
        state.panelList.asList().forEach((element) {
          var panelWidget = panelWidgetMap[element.uuid];
          if(panelWidget == null) {
              if(StringUtil.isEqual("console", element.type)) {
                panelWidget = ConsolePanel(element.uuid);
              } else if(StringUtil.isEqual("db", element.type)) {
                panelWidget =  DatabasePanel(element.uuid);
              } else if(StringUtil.isEqual("info", element.type)) {
                panelWidget =  InfoPanel();
              } else {
                panelWidget =  Container();
              }
              panelWidgetMap[element.uuid] = panelWidget;
          }
        });
        if(state.panelList.length != tabController.length) {
          tabController?.removeListener(tabChangedListener);
          tabController?.dispose();
          tabController = TabController(length: state.panelList.length, initialIndex: state.activePanelIndex, vsync: this);
          tabController.addListener(tabChangedListener);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExtendedTabBar(
              indicator: const ColorTabIndicator(Colors.blue),
              isScrollable: true,
              tabs: state.panelList.asMap().map((index, item) {
                var icon = Icon(Icons.cloud_circle_sharp, size: 20,);
                if(StringUtil.isEqual("console", item.type)) {
                  icon = Icon(Icons.web_asset, size: 20,);
                } else if(StringUtil.isEqual("db", item.type)) {
                  icon = Icon(Icons.table_view, size: 20,);
                } else if(StringUtil.isEqual("info", item.type)) {
                  icon = Icon(Icons.info, size: 20,);
                }
                return MapEntry(index, Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onDoubleTap: () {
                        context.read<MainPageBloc>().add(RedisListOpenEvent(!state.redisListOpen));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          icon,
                          SizedBox(width: 5,),
                          Text(item.name),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        context.read<MainPageBloc>().add(PanelCloseEvent(index));
                      },
                      child: Tooltip(
                        message: "关闭窗口",
                        child: Icon(Icons.close, size: 20,)
                      ),
                    ),
                  ],
                ));
              }).values.toList(),
              controller: tabController,
            ),
            Container(
              color: Colors.grey.withAlpha(128),
              height: 0.5,
            ),
            Expanded(
              child: IndexedStack(
                index: state.activePanelIndex,
                children: state.panelList.map((item) {
                  return panelWidgetMap[item.uuid];
                }).toList(),
              ),
            ),
            // Expanded(
            //   child: panelWidgetMap[state.panelList[state.activePanelIndex].uuid],
            // )
          ],
        );
      }
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
        var sessionID = Uuid().v4();
        Redis.instance.connectTo(connection.toJson()).then((value) async {
          return Redis.instance.createSession(connection.id, sessionID);
        }).then((value) {
          return Redis.instance.execute(connection.id, sessionID, "CONFIG GET databases");
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
              context.read<MainPageBloc>().add(PanelOpenEvent("info", connection, ""));
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
              context.read<MainPageBloc>().add(PanelOpenEvent("console", connection, ""));
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Tooltip(
                message: "打开控制台",
                child: Icon(Icons.web_asset),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              Redis.instance.close(connection.id).then((value) {
                context.read<MainPageBloc>().add(ConnectionCloseEvent(connection.id));

                context.read<NewConnectionBloc>().add(EditConnectionEvent(connection));
                newConnectionDialog(context);
              }).catchError((e) {
                BotToast.showText(text: "断开连接失败！");
              });
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    Icon(Icons.landscape),
                    SizedBox(width: 5,),
                    Text(key),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () async {
                        context.read<MainPageBloc>().add(PanelOpenEvent("db", connection, key.replaceAll("db", "")));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Tooltip(
                          message: "打开 DB",
                          child: Icon(Icons.table_view),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        context.read<MainPageBloc>().add(PanelOpenEvent("console", connection, key.replaceAll("db", "")));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Tooltip(
                          message: "打开控制台",
                          child: Icon(Icons.web_asset),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      }).values.toList() : [],
    );
  }

}