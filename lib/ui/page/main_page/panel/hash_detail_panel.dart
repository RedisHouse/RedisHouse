
import 'dart:async';
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:redis_house/bloc/database_panel_bloc.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

class HashDetailPanel extends StatefulWidget {
  final String keyName;
  HashDetailPanel(this.keyName) : super(key: ValueKey(keyName));
  @override
  State<StatefulWidget> createState() {
    return _HashDetailPanelState();
  }
}

class _HashDetailPanelState extends State<HashDetailPanel> with AfterInitMixin<HashDetailPanel> {

  TextEditingController _keyEditingController = TextEditingController();

  TextEditingController _renameTextEditingController = TextEditingController();
  TextEditingController _ttlTextEditingController = TextEditingController();

  TextEditingController _scanFilterTextEditingController = TextEditingController();
  TextEditingController _selectedKeyEditingController = TextEditingController();
  TextEditingController _selectedValueEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedKeyEditingController.addListener(_selectedKeyChanged);
    _selectedValueEditingController.addListener(_selectedValueChanged);
  }

  void _selectedKeyChanged() {
    context.read<DatabasePanelBloc>().add(HashSelectedKeyChanged(_selectedKeyEditingController.text));
  }

  void _selectedValueChanged() {
    context.read<DatabasePanelBloc>().add(HashSelectedValueChanged(_selectedValueEditingController.text));
  }

  StreamSubscription keyDetailStreamSubscription;
  @override
  void didInitState() {
    keyDetailStreamSubscription = BlocProvider.of<DatabasePanelBloc>(context).listen((DatabasePanelData data) {
      if(mounted && data != null && data.keyDetail != null && data.keyDetail is HashKeyDetail) {
        HashKeyDetail keyDetail = data.keyDetail;
        _keyEditingController.text = keyDetail.key;
        _renameTextEditingController.text = keyDetail.key;
        _ttlTextEditingController.text = "${keyDetail.ttl}";
      }
    });
    HashKeyDetail keyDetail = context.read<DatabasePanelBloc>().state.keyDetail;
    _keyEditingController.text = keyDetail.key;
    _renameTextEditingController.text = keyDetail.key;
    _ttlTextEditingController.text = "${keyDetail.ttl}";
  }

  @override
  void dispose() {
    super.dispose();
    _selectedKeyEditingController?.removeListener(_selectedKeyChanged);
    _selectedValueEditingController?.removeListener(_selectedValueChanged);

    keyDetailStreamSubscription?.cancel();
    _keyEditingController?.dispose();
    _selectedValueEditingController?.dispose();
    _renameTextEditingController?.dispose();
    _ttlTextEditingController?.dispose();
    _scanFilterTextEditingController?.dispose();
    _selectedKeyEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
      builder: (context, state) {
        var panelUUID = state.panelUUID;
        var connection = state.connection;
        HashKeyDetail keyDetail = state.keyDetail;
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
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
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
                              context.read<DatabasePanelBloc>().add(KeyRenameEvent(state.keyDetail.key, _renameTextEditingController.text));
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
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("修改 TTL"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: TextField(
                            controller: _ttlTextEditingController,
                            minLines: 1,
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "TTL"
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
                          Redis.instance.execute(connection.id, panelUUID, " EXPIRE ${state.keyDetail.key} ${_ttlTextEditingController.text}").then((value) {
                            context.read<DatabasePanelBloc>().add(KeyTTLChanged(int.tryParse(_ttlTextEditingController.text)));
                            BotToast.showText(text: "TTL 已修改。");
                          });
                        }
                      });
                    },
                    child: Text("TTL: ${state.keyDetail.ttl}"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("删除 KEY"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: Text(
                              "确定删除【${state.keyDetail.key}】？"
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                          FlatButton(child: Text("删除", style: TextStyle(color: Colors.red),),onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                        ],
                      ).show(context).then((value) {
                        if(value??false) {
                          Redis.instance.execute(connection.id, panelUUID, "del ${state.keyDetail.key}").then((value) {
                            context.read<DatabasePanelBloc>().add(KeyDelete(state.keyDetail.key));
                            BotToast.showText(text: "已删除。");
                          });
                        }
                      });
                    },
                    child: Text("删除"),
                  ),
                ],
              ),
            ),
            _keyValuePanel(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: _selectedKeyEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                  )),
                  Offstage(
                    offstage: StringUtil.isEqual(keyDetail.selectedKey, _selectedKeyEditingController.text),
                    child: Container(
                      padding: EdgeInsets.only(left: 8,),
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          // Redis.instance.execute(connection.id, panelUUID, "set ${keyDetail.key} ${_valueEditingController.text}").then((value) {
                          //   if(StringUtil.isEqual("OK", value)) {
                          //     context.read<DatabasePanelBloc>().add(StringNewValue(_valueEditingController.text));
                          //   } else {
                          //     BotToast.showText(text: "$value");
                          //   }
                          // }).catchError((e) {
                          //   BotToast.showText(text: "$e");
                          // });
                        },
                        child: Text("更新"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _selectedValueEditingController,
                maxLines: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            )),
            Offstage(
              offstage: StringUtil.isEqual(keyDetail.selectedValue, _selectedValueEditingController.text),
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 8, bottom: 8,),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    // Redis.instance.execute(connection.id, panelUUID, "set ${keyDetail.key} ${_valueEditingController.text}").then((value) {
                    //   if(StringUtil.isEqual("OK", value)) {
                    //     context.read<DatabasePanelBloc>().add(StringNewValue(_valueEditingController.text));
                    //   } else {
                    //     BotToast.showText(text: "$value");
                    //   }
                    // }).catchError((e) {
                    //   BotToast.showText(text: "$e");
                    // });
                  },
                  child: Text("更新"),
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _keyValuePanel() {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
      buildWhen: (previous, current) {
        return previous.keyDetail != current.keyDetail;
      },
      builder: (context, state) {
        HashKeyDetail keyDetail = state.keyDetail;
        return Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.black26,
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 1,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.blueGrey,
                            child: Center(child: Text("ROW")),
                          ),
                        ),
                        SizedBox(width: 1,),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.blueGrey,
                            child: Center(child: Text("KEY")),
                          ),
                        ),
                        SizedBox(width: 1,),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.blueGrey,
                            child: Center(child: Text("VALUE")),
                          ),
                        ),
                        SizedBox(width: 1,),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(3),
                          },
                          border: TableBorder.all(),
                          children: _hashKeyValueRow(keyDetail),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8,),
              _controlKeyValuePanel(),
            ],
          ),
        );
      }
    );
  }


  List<TableRow> _hashKeyValueRow(HashKeyDetail keyDetail) {
    if(keyDetail.scanKeyValueMap == null || keyDetail.scanKeyValueMap.isEmpty) {
      return [];
    }
    int counter = 1;
    return keyDetail.scanKeyValueMap.map<String, TableRow>((key, value) {
      return MapEntry(key, TableRow(
        decoration: BoxDecoration(
            color: StringUtil.isEqual(keyDetail.selectedKey, key) ? Colors.greenAccent.withAlpha(128) : Colors.blueGrey.withAlpha(128)
        ),
        children: [
          GestureDetector(
            onTap: () => _onKeySelected(key, value),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("${counter++}")),
            ),
          ),
          GestureDetector(
            onTap: () => _onKeySelected(key, value),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("$key")),
            ),
          ),
          GestureDetector(
            onTap: () => _onKeySelected(key, value),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("$value")),
            ),
          ),
        ]
      ));
    }).values.toList();
  }

  void _onKeySelected(String key, String value) {
    _selectedKeyEditingController.text = key;
    _selectedValueEditingController.text = value;
    context.read<DatabasePanelBloc>().add(HashSelectedKeyValue(key, value));
  }

  Widget _controlKeyValuePanel() {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
        buildWhen: (previous, current) {
          return previous.keyDetail != current.keyDetail;
        },
      builder: (context, state) {
        HashKeyDetail keyDetail = state.keyDetail;
        return Container(
          width: 200,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MaterialButton(
                        color: Colors.blueAccent.withAlpha(128),
                        onPressed: () {
                          BotToast.showText(text: "刷新");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(width: 5,),
                              Text("刷新")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2,),
                      MaterialButton(
                        color: Colors.blueAccent.withAlpha(128),
                        onPressed: () {
                          BotToast.showText(text: "添加行");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(width: 5,),
                              Text("添加行")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2,),
                      MaterialButton(
                        color: Colors.blueAccent.withAlpha(128),
                        onPressed: () {
                          BotToast.showText(text: "删除行");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 5,),
                              Text("删除行")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      TextField(
                        controller: _scanFilterTextEditingController,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: "KEY 关键字",
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                      ),
                      SizedBox(height: 8,),

                    ],
                  ),
                ),
              ),
              Text("Keys: ${keyDetail.hlen}"),
              Row(
                children: [
                  Expanded(child: MaterialButton(
                    onPressed: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    )
                  )),
                  Expanded(child: MaterialButton(
                      onPressed: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward),
                      )
                  )),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
  
}