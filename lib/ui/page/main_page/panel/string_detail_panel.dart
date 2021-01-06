
import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/key_detail_bloc.dart';
import 'package:redis_house/bloc/model/key_detail_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';

class StringDetailPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StringDetailPanelState();
  }
}

class _StringDetailPanelState extends State<StringDetailPanel> with AfterInitMixin<StringDetailPanel> {

  TextEditingController _keyEditingController = TextEditingController();
  TextEditingController _valueEditingController = TextEditingController();

  TextEditingController _renameTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  StreamSubscription keyDetailStreamSubscription;
  @override
  void didInitState() {
    keyDetailStreamSubscription = BlocProvider.of<KeyDetailBloc>(context).listen((KeyDetailData data) {
      Log.d("StringKeyDetail~~~~~~~~~~~~~~~~~~~~~~~~~~`");
      StringKeyDetail keyDetail = data.keyDetail;
      _keyEditingController.text = keyDetail.key;
      _valueEditingController.text = keyDetail.value;
      _renameTextEditingController.text = keyDetail.key;
    });
    StringKeyDetail keyDetail = context.read<KeyDetailBloc>().state.keyDetail;
    _keyEditingController.text = keyDetail.key;
    _valueEditingController.text = keyDetail.value;
    _renameTextEditingController.text = keyDetail.key;
  }

  @override
  void dispose() {
    super.dispose();
    keyDetailStreamSubscription?.cancel();
    _keyEditingController?.dispose();
    _valueEditingController?.dispose();
    _renameTextEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyDetailBloc, KeyDetailData>(
      builder: (BuildContext context, state) {
        var panelUUID = state.panelUUID;
        var connection = state.connection;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text("${state.keyDetail.type.toUpperCase()}"),
                  SizedBox(width: 10,),
                  Expanded(child: TextField(
                    readOnly: true,
                    controller: _keyEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                  )),
                  MaterialButton(
                    onPressed: () async {
                      _renameTextEditingController.text = state.keyDetail.key;
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("重命名 Key"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: TextField(
                            controller: _renameTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                          FlatButton(child: Text("保存", style: TextStyle(color: Colors.blue),),onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                        ],
                      ).show(context).then((value) {
                        if(value??false) {
                          Redis.instance.execute(connection.id, panelUUID, "renamenx ${state.keyDetail.key} ${_renameTextEditingController.text}").then((value) {
                            if(value == 1) {
                              context.read<KeyDetailBloc>().add(KeyRenameEvent(state.keyDetail.key, _renameTextEditingController.text));
                              BotToast.showText(text: "重命名成功。");
                            } else {
                              BotToast.showText(text: "KEY 已存在！");
                            }
                          }).catchError((e) {
                            BotToast.showText(text: "$e");
                          });
                        }
                      });
                    },
                    child: Text("重命名"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      BotToast.showText(text: "修改 TTL");
                    },
                    child: Text("TTL: ${state.keyDetail.ttl}"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      BotToast.showText(text: "删除 KEY");
                    },
                    child: Text("删除"),
                  ),
                ],
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _valueEditingController,
                maxLines: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            )),
          ],
        );
      },
    );
  }

}