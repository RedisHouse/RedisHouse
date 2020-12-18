
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

class ConsolePanel extends StatefulWidget {
  final String panelUUID;
  ConsolePanel(this.panelUUID,) : super(key: ValueKey(panelUUID));
  @override
  State<StatefulWidget> createState() {
    return _ConsolePanelState();
  }
}

class _ConsolePanelState extends State<ConsolePanel> with AfterInitMixin<ConsolePanel>, AutomaticKeepAliveClientMixin<ConsolePanel> {

  TextEditingController _textEditingController = TextEditingController();
  List<String> commandList = [];
  String connectionId;
  @override
  void didInitState() {
    var mainPageData = context.read<MainPageBloc>().state;
    var panelData = mainPageData.panelList.where((item) => StringUtil.isEqual(widget.panelUUID, item.uuid)).first;
    var connection = panelData.connection;
    connectionId = connection.id;
    var dbIndex = StringUtil.isNotBlank(panelData.dbIndex) ? panelData.dbIndex : "0";
    Redis.instance.createSession(connection.id, panelData.uuid).then((value) {
      return Redis.instance.execute(connection.id, panelData.uuid, "select $dbIndex");
    }).then((value) {
      BotToast.showText(text: "会话创建完成。");
    });
  }

  @override
  void dispose() {
    super.dispose();
    Redis.instance.closeSession(connectionId, widget.panelUUID).then((value) {
      Log.i("Session 已关闭: [$connectionId]-[${widget.panelUUID}]");
    }).catchError((e) {
      Log.e("Session 关闭失败：[$connectionId]-[${widget.panelUUID}]");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(child: ListView.builder(
          itemCount: commandList.length,
          itemBuilder: (context, index) {
            return Text(commandList[index]);
          },
        )),
        TextField(
          maxLines: 1,
          controller: _textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: "mysql.testdata.online >"
          ),
          onSubmitted: (s) {
            Redis.instance.execute(connectionId, widget.panelUUID, s).then((value) {
              commandList.add("mysql.testdata.online >$s\n$value");
              _textEditingController.clear();
              setState(() {

              });
            }).catchError((e) {
              commandList.add("mysql.testdata.online >$s\n$e");
              _textEditingController.clear();
              setState(() {

              });
            });

          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

}