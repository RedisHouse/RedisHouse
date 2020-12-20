
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  PanelInfo panelInfo;
  @override
  void didInitState() {
    var mainPageBloc = context.read<MainPageBloc>();
    var mainPageData = mainPageBloc.state;
    panelInfo = mainPageData.panelList.where((item) => StringUtil.isEqual(widget.panelUUID, item.uuid)).first;
    connection = panelInfo.connection;
    var dbIndex = StringUtil.isNotBlank(panelInfo.dbIndex) ? panelInfo.dbIndex : "0";
    Redis.instance.createSession(connection.id, panelInfo.uuid).then((value) {
      return Redis.instance.execute(connection.id, panelInfo.uuid, "select $dbIndex");
    }).then((value) {
      BotToast.showText(text: "会话创建完成。");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(child: Text("Database", style: TextStyle(fontSize: 50),)),
    );
  }

}