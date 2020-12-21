
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_button/menu_button.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

class DatabasePanel extends StatefulWidget {
  final String panelUUID;
  DatabasePanel(this.panelUUID);
  @override
  State<StatefulWidget> createState() {
    return _DatabasePanelState();
  }
}

class _DatabasePanelState extends State<DatabasePanel> with AfterInitMixin<DatabasePanel>  {

  NewConnectionData connection;
  ConnectionDetail connectionDetail;
  PanelInfo panelInfo;
  int dbSize = 0;
  String dbIndex = "0";

  int scanCount = 20;
  List scanKeyList = List.empty(growable: true);
  int navScanIndex = 0;
  List<int> navScanIndexList = List.of([0], growable: true);

  @override
  void didInitState() {
    var mainPageBloc = context.read<MainPageBloc>();
    var mainPageData = mainPageBloc.state;
    panelInfo = mainPageData.panelList.where((item) => StringUtil.isEqual(widget.panelUUID, item.uuid)).first;
    connection = panelInfo.connection;
    connectionDetail = mainPageData.connectedRedisMap[connection.id];
    dbIndex = StringUtil.isNotBlank(panelInfo.dbIndex) ? panelInfo.dbIndex : "0";
    Redis.instance.createSession(connection.id, panelInfo.uuid).then((value) {
      BotToast.showText(text: "会话创建完成。");
      selectAndSize();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Redis.instance.closeSession(connection.id, widget.panelUUID).then((value) {
      Log.i("Session 已关闭: [${connection.id}]-[${widget.panelUUID}]");
    }).catchError((e) {
      Log.e("Session 关闭失败：[${connection.id}]-[${widget.panelUUID}]");
    });
  }

  selectAndSize() {
    Redis.instance.execute(connection.id, panelInfo.uuid, "select $dbIndex").then((value) {
      return Redis.instance.execute(connection.id, panelInfo.uuid, "dbsize");
    }).then((value) {
      setState(() {
        dbSize = value;
      });
      Log.d("dbSize：$value");
      loadKeyList();
    }).catchError((e) {
      BotToast.showText(text: "$e");
    });
  }

  loadKeyList() {
    var scanIndex = navScanIndexList[navScanIndex];
    Log.d("scanIndex: $scanIndex, $navScanIndexList");
    Redis.instance.execute(connection.id, panelInfo.uuid, "scan $scanIndex count $scanCount").then((value) {
      Log.d("Key List: $value");
      if(navScanIndexList.length == 1 || navScanIndexList.last != 0) {
        navScanIndexList.add(int.tryParse(value[0]));
      }
      scanKeyList.clear();
      scanKeyList.addAll(value[1]);
      setState(() {

      });
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
              "db$dbIndex",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
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
        // MaterialButton(
        //   onPressed: () async {
        //     for(int i = 0; i < 100; i++) {
        //       await Redis.instance.execute(connection.id, widget.panelUUID, "set name$i hubin-$i");
        //     }
        //   },
        //   child: Text("造数据"),
        // )
        Container(
          width: 300,
          color: Colors.black12,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MenuButton(
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
                      if(StringUtil.isNotEqual(value, dbIndex)) {
                        setState(() {
                          dbIndex = value;
                          dbSize = 0;
                          navScanIndex = 0;
                          navScanIndexList = List.of([0], growable: true);
                          scanKeyList.clear();
                        });
                        selectAndSize();
                      }
                    },
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withAlpha(128)),
                      borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                      color: Colors.black12,
                    ),
                    onMenuButtonToggle: (toggle) {

                    },
                  ),
                  SizedBox(width: 5,),
                  Text("Keys: $dbSize"),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        dbSize = 0;
                        navScanIndex = 0;
                        navScanIndexList = List.of([0], growable: true);
                        scanKeyList.clear();
                      });
                      selectAndSize();
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
              Expanded(child: ListView.separated(
                itemCount: scanKeyList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(scanKeyList[index]),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: navScanIndex  > 0 ? () {
                      navScanIndex--;
                      loadKeyList();
                    } : null,
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
                  Expanded(child: Container()),
                  InkWell(
                    onTap: (navScanIndex < navScanIndexList.length-1 && navScanIndexList[navScanIndex+1] != 0) ? () {
                      navScanIndex++;
                      loadKeyList();
                    } : null,
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
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  List<String> dbList(int dbNum) {
    List<String> dbList = [];
    for(int i = 0; i < dbNum; i++) {
      dbList.add("$i");
    }
    return dbList;
  }

}