
import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_button/menu_button.dart';
import 'package:redis_house/bloc/database_panel_bloc.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/ui/page/main_page/panel/hash_detail_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/list_detail_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/set_detail_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/string_detail_panel.dart';
import 'package:redis_house/ui/page/main_page/panel/zset_detail_panel.dart';
import 'package:redis_house/util/string_util.dart';

class DatabasePanel extends StatefulWidget {
  final String panelUUID;
  DatabasePanel(this.panelUUID): super(key: ValueKey(panelUUID));
  @override
  State<StatefulWidget> createState() {
    return _DatabasePanelState();
  }
}

class _DatabasePanelState extends State<DatabasePanel> with AfterInitMixin<DatabasePanel>  {

  NewConnectionData connection;
  ConnectionDetail connectionDetail;
  PanelInfo panelInfo;
  DatabasePanelData databasePanelData;

  int scanCount = 20;

  StreamSubscription streamSubscription;
  @override
  void didInitState() {
    streamSubscription = context.read<DatabasePanelBloc>().listen((data) {
      databasePanelData = data;
    });
    databasePanelData = context.read<DatabasePanelBloc>().state;
    var mainPageData = context.read<MainPageBloc>().state;
    panelInfo = mainPageData.panelList.where((item) => StringUtil.isEqual(widget.panelUUID, item.uuid)).first;
    connection = panelInfo.connection;
    connectionDetail = mainPageData.connectedRedisMap[connection.id];
    Redis.instance.createSession(connection.id, panelInfo.uuid).then((value) {
      BotToast.showText(text: "会话创建完成。");
      selectAndSize(databasePanelData.dbIndex);
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
    Redis.instance.closeSession(connection.id, widget.panelUUID).then((value) {
      Log.i("Session 已关闭: [${connection.id}]-[${widget.panelUUID}]");
    }).catchError((e) {
      Log.e("Session 关闭失败：[${connection.id}]-[${widget.panelUUID}]");
    });
  }

  selectAndSize(String dbIndex) {
    Redis.instance.execute(connection.id, panelInfo.uuid, "select $dbIndex").then((value) {
      return Redis.instance.execute(connection.id, panelInfo.uuid, "dbsize");
    }).then((value) {
      context.read<DatabasePanelBloc>().add(DBORDBSizeChanged(dbSize: value));
      Log.d("DB${databasePanelData.dbIndex}-dbSize：$value");
      loadKeyList(0);
    }).catchError((e) {
      BotToast.showText(text: "$e");
    });
  }

  loadKeyList(int navScanIndex) {
    var scanIndex = databasePanelData.navScanIndexList[navScanIndex];
    Log.d("scanIndex: $scanIndex, ${databasePanelData.navScanIndexList}");
    Redis.instance.execute(connection.id, panelInfo.uuid, "scan $scanIndex count $scanCount").then((value) {
      Log.d("Key List: $value");
      if(databasePanelData.navScanIndexList.length == 1 || databasePanelData.navScanIndexList.last != 0) {
        context.read<DatabasePanelBloc>().add(KeyScanNavIndexListAdd(int.tryParse(value[0])));
      }
      List<String> scanKeyList = List.of(value[1]).map((e) => "$e").toList();
      context.read<DatabasePanelBloc>().add(ScanKeyListChanged(scanKeyList));
    }).catchError((e) {
      BotToast.showText(text: "$e");
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget button = Container(
      width: 75,
      height: 25,
      color: Colors.black12,
      padding: const EdgeInsets.only(left: 16, right: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              "db${databasePanelData.dbIndex}",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )
          ),
          SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )
              )
          ),
        ],
      ),
    );
    return Row(
      children: [
        Container(
          width: 300,
          color: Colors.black12,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
                    buildWhen: (previous, current) => previous.dbIndex != current.dbIndex,
                    builder: (context, state) {
                      return MenuButton(
                        child: button,// Widget displayed as the button
                        items: dbList(connectionDetail.dbNum),// List of your items
                        topDivider: true,
                        popupHeight: 435, // This popupHeight is optional. The default height is the size of items
                        scrollPhysics: ClampingScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                        itemBuilder: (value) => Container(
                            width: 75,
                            height: 25,
                            color: Colors.black,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text("db$value")
                        ),// Widget displayed for each item
                        toggledChild: Container(
                          color: Colors.black12,
                          child: button,// Widget displayed as the button,
                        ),
                        divider: Container(
                          height: 0.5,
                          color: Colors.grey.withAlpha(128),
                        ),
                        onItemSelected: (value) {
                          if(StringUtil.isNotEqual(value, databasePanelData.dbIndex)) {
                            context.read<DatabasePanelBloc>().add(DBORDBSizeChanged(dbIndex: value));
                            context.read<DatabasePanelBloc>().add(ScanKeyListClear());
                            context.read<DatabasePanelBloc>().add(KeyScanNavIndexListClear());
                            selectAndSize(value);
                          }
                        },
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withAlpha(128)),
                          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                          color: Colors.black12,
                        ),
                        onMenuButtonToggle: (toggle) {

                        },
                      );
                    }
                  ),
                  SizedBox(width: 5,),
                  BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
                    buildWhen: (previous, current) => previous.dbSize != current.dbSize,
                    builder: (context, state) {
                      return Text("Keys: ${state.dbSize??0}");
                    }
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () async {
                      context.read<DatabasePanelBloc>().add(ScanKeyListClear());
                      context.read<DatabasePanelBloc>().add(KeyScanNavIndexListClear());
                      selectAndSize(databasePanelData.dbIndex);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Tooltip(
                          message: "刷新",
                          child: Icon(Icons.refresh, size: 20,)
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
                buildWhen: (previous, current) {
                  return StringUtil.isNotEqual(previous.selectedKey, current.selectedKey)
                    || previous.scanKeyList != current.scanKeyList;
                },
                builder: (context, state) {
                  return Expanded(child: ListView.separated(
                    itemCount: state.scanKeyList?.length??0,
                    itemBuilder: (context, index) {
                      String keyName = state.scanKeyList[index];
                      bool selected = StringUtil.isEqual(state.selectedKey, keyName);
                      return InkWell(
                        onTap: () {
                          _getKeyDetail(keyName).then((keyDetail) {
                            if(keyDetail != null) {
                              context.read<DatabasePanelBloc>().add(KeyDetailChanged(keyDetail));
                              context.read<DatabasePanelBloc>().add(SelectedKey(keyName));
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              selected ? Icon(Icons.check, color: Colors.green,) : Container(),
                              SizedBox(width: selected ? 5 : 0,),
                              Text(keyName),

                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ));
                }
              ),
              BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
                buildWhen: (previous, current) {
                  return previous.navScanIndex != current.navScanIndex
                    || previous.navScanIndexList != current.navScanIndexList;
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Offstage(
                        offstage: state.navScanIndex <= 0,
                        child: InkWell(
                          onTap: () {
                            int index = state.navScanIndex - 1;
                            loadKeyList(index);
                            context.read<DatabasePanelBloc>().add(KeyScanNavIndexChanged(index));
                          },
                          hoverColor: Colors.red.withAlpha(128),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_back),
                                SizedBox(width: 5,),
                                Text("上一页")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Offstage(
                        offstage: state.navScanIndex >= state.navScanIndexList.length-1 || state.navScanIndexList[state.navScanIndex+1] == 0,
                        child: InkWell(
                          onTap: () {
                            int index = state.navScanIndex + 1;
                            loadKeyList(index);
                            context.read<DatabasePanelBloc>().add(KeyScanNavIndexChanged(index));
                          },
                          hoverColor: Colors.red.withAlpha(128),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_forward),
                                SizedBox(width: 5,),
                                Text("下一页")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              )
            ],
          ),
        ),
        Expanded(child: BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
          buildWhen: (previous, current) {
            return StringUtil.isNotEqual(previous.selectedKey, current.selectedKey)
                || previous.keyDetail != current.keyDetail;
          },
          builder: (context, state) {
            return _keyDetailPanel(state.keyDetail);
          }
        ),),
      ],
    );
  }

  Future<BaseKeyDetail> _getKeyDetail(String key) async {
    try {
      var keyDetail;
      String keyType = await Redis.instance.execute(connection.id, panelInfo.uuid, "type $key");
      if(StringUtil.isEqual("string", keyType)) {
        String keyValue = await Redis.instance.execute(connection.id, panelInfo.uuid, "get $key");
        keyDetail = StringKeyDetail((b)=>b..key=key..type=keyType..value=keyValue);
      } else if(StringUtil.isEqual("hash", keyType)) {
        keyDetail = HashKeyDetail((b)=>b..key=key..type=keyType);
        int hlen = await Redis.instance.execute(connection.id, panelInfo.uuid, "hlen $key");
        var scanResult = await Redis.instance.execute(connection.id, panelInfo.uuid, "hscan $key 0 count $scanCount");
        int scanIndex = int.tryParse(scanResult[0]);
        List<String> keyValueList = List.of(scanResult[1]).map((e) => "$e").toList();
        Map<String, String> scanKeyValueMap = {};
        keyValueList.asMap().forEach((index, element) {
          if(index % 2 != 0) {
            scanKeyValueMap["${keyValueList[index-1]}"] = "$element";
          }
        });
        keyDetail = keyDetail.rebuild((b)=>b
          ..hlen = hlen
          ..scanIndex = scanIndex
          ..scanKeyValueMap = BuiltMap<String, String>.from(scanKeyValueMap).toBuilder()
        );
      } else if(StringUtil.isEqual("list", keyType)) {
        keyDetail = ListKeyDetail((b)=>b..key=key..type=keyType);
        int llen = await Redis.instance.execute(connection.id, panelInfo.uuid, "llen $key");
        List rangeList = await Redis.instance.execute(connection.id, panelInfo.uuid, "lrange $key 0 ${scanCount-1}");
        List<String> valueList = List.of(rangeList).map((e) => "$e").toList();
        keyDetail = keyDetail.rebuild((b)=>b
          ..llen = llen
          ..pageIndex = 1
          ..rangeList = valueList.toBuiltList().toBuilder()
        );
      } else if(StringUtil.isEqual("set", keyType)) {
        keyDetail = SetKeyDetail((b)=>b..key=key..type=keyType);
        int slen = await Redis.instance.execute(connection.id, panelInfo.uuid, "scard $key");
        var scanResult = await Redis.instance.execute(connection.id, panelInfo.uuid, "sscan $key 0 count $scanCount");
        int scanIndex = int.tryParse(scanResult[0]);
        List<String> valueList = List.of(scanResult[1]).map((e) => "$e").toList();
        keyDetail = keyDetail.rebuild((b)=>b
          ..slen = slen
          ..scanIndex = scanIndex
          ..scanList = valueList.toBuiltList().toBuilder()
        );
      } else if(StringUtil.isEqual("zset", keyType)) {
        keyDetail = ZSetKeyDetail((b)=>b..key=key..type=keyType);


      } else if(StringUtil.isEqual("none", keyType)) {
        throw "KEY 不存在，请刷新！";
      } else {
        throw "INVALID KEY TYPE";
      }
      int keyTTL = await Redis.instance.execute(connection.id, panelInfo.uuid, "ttl $key");
      keyDetail = keyDetail.rebuild((b)=>b..ttl=keyTTL);
      Log.d("KeyDetail: $keyDetail");
      return keyDetail;
    } catch(e) {
      BotToast.showText(text: "$e");
      return null;
    }
  }

  Widget _keyDetailPanel(BaseKeyDetail keyDetail) {
    if(keyDetail == null) {
      return Container();
    }
    if(StringUtil.isEqual("string", keyDetail.type)) {
      return StringDetailPanel(keyDetail.key);
    } else if(StringUtil.isEqual("hash", keyDetail.type)) {
      return HashDetailPanel(keyDetail.key);
    } else if(StringUtil.isEqual("list", keyDetail.type)) {
      return ListDetailPanel(keyDetail.key);
    } else if(StringUtil.isEqual("set", keyDetail.type)) {
      return SetDetailPanel(keyDetail.key);
    } else if(StringUtil.isEqual("zset", keyDetail.type)) {
      return ZSetDetailPanel(keyDetail.key);
    }
    return Container();
  }

  List<String> dbList(int dbNum) {
    List<String> dbList = [];
    for(int i = 0; i < dbNum; i++) {
      dbList.add("$i");
    }
    return dbList;
  }

}