import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

class ConsolePanel extends StatefulWidget {
  final String panelUUID;
  ConsolePanel(this.panelUUID,);
  @override
  State<StatefulWidget> createState() {
    return _ConsolePanelState();
  }
}

class _ConsolePanelState extends State<ConsolePanel> with AfterInitMixin<ConsolePanel> {

  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _keyboardFocusNode = FocusNode();
  List<String> commandList = [];
  NewConnectionData connection;
  PanelInfo panelInfo;

  int commandHistoryIndex = 0;
  List<String> commandHistoryList = [];

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
    _focusNode.requestFocus();
    mainPageBloc.listen((state) {
      if(state.panelList == null || state.panelList.length == 0) {
        return;
      }
      var activePanel = state.panelList[state.activePanelIndex];
      if(StringUtil.isEqual(widget.panelUUID, activePanel.uuid)) {
        _focusNode.requestFocus();
        if(activePanel.dbIndex != panelInfo.dbIndex) {
          if(mounted) {
            setState(() {
              panelInfo = activePanel;
            });
          }
        }
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
    var dbIndex = StringUtil.isNotBlank(panelInfo.dbIndex) ? panelInfo.dbIndex : "0";
    return RawKeyboardListener(
      focusNode: _keyboardFocusNode,
      autofocus: true,
      onKey: onKeyEvent,
      child: SingleChildScrollView(
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
                  prefixText: "${connection.redisName}:$dbIndex > "
              ),
              onSubmitted: (s) {
                if(StringUtil.isBlank(s) || s.trim().length == 0) {
                  BotToast.showText(text: "请输入命令");
                  _focusNode.requestFocus();
                  return;
                }
                var commandArgList = s.trim().split(" ").where((element) => StringUtil.isNotBlank(element)).toList();
                Log.d("命令：${commandArgList}");
                Redis.instance.execute(connection.id, widget.panelUUID, s).then((value) {
                  addCommandList(s);
                  if(value is List) {
                    commandList.add("${connection.redisName}:$dbIndex > $s\n${formatListOutput(0, value)}");
                  } else {
                    commandList.add("${connection.redisName}:$dbIndex > $s\n$value");
                  }
                  _textEditingController.clear();
                  if(StringUtil.isEqual(commandArgList[0], "select")) {
                    int activePanel = context.read<MainPageBloc>().state.activePanelIndex;
                    Log.d("PanelDBChangeEvent($activePanel, ${commandArgList[1]})");
                    context.read<MainPageBloc>().add(PanelDBChangeEvent(activePanel, commandArgList[1]));
                  }
                  setState(() {

                  });
                }).catchError((e) {
                  commandList.add("${connection.redisName}:$dbIndex > $s\n$e");
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
      ),
    );
  }

  void addCommandList(String command) {
    bool singleTop = commandHistoryList.isEmpty || StringUtil.isNotEqual(command, commandHistoryList[commandHistoryList.length-1]);
    if(singleTop) {
      commandHistoryList.add(command);
    }
    commandHistoryIndex = commandHistoryList.length;
  }

  String previousCommand() {
    commandHistoryIndex--;
    if(commandHistoryIndex >= 0) {
      return commandHistoryList[commandHistoryIndex];
    } else {
      commandHistoryIndex = 0;
      return commandHistoryList[commandHistoryIndex];
    }
  }

  String nextCommand() {
    commandHistoryIndex++;
    if(commandHistoryIndex < commandHistoryList.length) {
      return commandHistoryList[commandHistoryIndex];
    } else {
      commandHistoryIndex = commandHistoryList.length;
      return null;
    }
  }

  String formatListOutput(int level, List value) {
    StringBuffer stringBuffer = StringBuffer();
    for(int i = 0; i < value.length; i++) {
      for(int j = 0; j < level; j++) {
        stringBuffer.write('        ');
      }
      stringBuffer.write("${sprintf("%8i", [i+1])})");
      if(value[i] is List) {
        stringBuffer.write("\n");
        stringBuffer.write(formatListOutput(level+1, value[i]));
      } else {
        stringBuffer.write("        ");
        stringBuffer.write("${value[i]}");
      }
      stringBuffer.write("\n");
    }
    return stringBuffer.toString();
  }

  void onKeyEvent(RawKeyEvent event) {
    switch (event.runtimeType) {
      case RawKeyDownEvent:
        // 按下
        break;
      case RawKeyUpEvent:
        // 松开
        if(StringUtil.isEqual("Arrow Up", event.physicalKey.debugName)) {
          String command = previousCommand();
          _textEditingController.clear();
          if(StringUtil.isNotBlank(command)) {
            // _textEditingController.text = command;
            _textEditingController.value = TextEditingValue(text: command, selection: TextSelection.collapsed(offset: command.length));
          }
        } else if(StringUtil.isEqual("Arrow Down", event.physicalKey.debugName)) {
          String command = nextCommand();
          _textEditingController.clear();
          if(StringUtil.isNotBlank(command)) {
            // _textEditingController.text = command;
            _textEditingController.value = TextEditingValue(text: command, selection: TextSelection.collapsed(offset: command.length));
          }
        }
        break;
      default:
        break;
    }
  }

}
