import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
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

class _ConsolePanelState extends State<ConsolePanel> with AfterInitMixin<ConsolePanel> {

  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<String> commandList = [];
  NewConnectionData connection;
  @override
  void didInitState() {
    var mainPageBloc = context.read<MainPageBloc>();
    var mainPageData = mainPageBloc.state;
    var panelData = mainPageData.panelList.where((item) => StringUtil.isEqual(widget.panelUUID, item.uuid)).first;
    connection = panelData.connection;
    var dbIndex = StringUtil.isNotBlank(panelData.dbIndex) ? panelData.dbIndex : "0";
    Redis.instance.createSession(connection.id, panelData.uuid).then((value) {
      return Redis.instance.execute(connection.id, panelData.uuid, "select $dbIndex");
    }).then((value) {
      BotToast.showText(text: "会话创建完成。");
    });
    _focusNode.requestFocus();
    mainPageBloc.listen((state) {
      if(state.panelList == null || state.panelList.length == 0) {
        return;
      }
      if(StringUtil.isEqual(widget.panelUUID, state.panelList[state.activePanelIndex].uuid)) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController?.dispose();
    _focusNode?.dispose();
    Redis.instance.closeSession(connection.id, widget.panelUUID).then((value) {
      Log.i("Session 已关闭: [${connection.id}]-[${widget.panelUUID}]");
    }).catchError((e) {
      Log.e("Session 关闭失败：[${connection.id}]-[${widget.panelUUID}]");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(commandList.join("\n")),
          TextField(
            maxLines: 1,
            controller: _textEditingController,
            focusNode: _focusNode,
            autofocus: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixText: "${connection.redisName} >"
            ),
            onSubmitted: (s) {
              if(StringUtil.isBlank(s) || s.trim().length == 0) {
                BotToast.showText(text: "请输入命令");
                _focusNode.requestFocus();
                return;
              }
              Redis.instance.execute(connection.id, widget.panelUUID, s).then((value) {
                commandList.add("${connection.redisName} >$s\n$value");
                _textEditingController.clear();
                setState(() {

                });
              }).catchError((e) {
                if(e is PlatformException) {
                  Log.d("ExceptionCode: ${e.code}");
                  Log.d("ExceptionMessage: ${e.message}");
                  Log.d("ExceptionDetails: ${e.details}");
                }
                commandList.add("${connection.redisName} >$s\n$e");
                _textEditingController.clear();
                setState(() {

                });
              }).whenComplete(() {
                _focusNode.requestFocus();
              });

            },
          )
        ],
      ),
    );
  }

}
