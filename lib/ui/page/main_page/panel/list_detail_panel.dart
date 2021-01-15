
import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:redis_house/bloc/database_panel_bloc.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/ui/page/main_page/dialog/new_value_dialog.dart';
import 'package:redis_house/util/string_util.dart';

class ListDetailPanel extends StatefulWidget {
  final String keyName;
  ListDetailPanel(this.keyName) : super(key: ValueKey(keyName));
  @override
  State<StatefulWidget> createState() {
    return _ListDetailPanelState();
  }
}

class _ListDetailPanelState extends State<ListDetailPanel> with AfterInitMixin<ListDetailPanel>  {

  TextEditingController _keyEditingController = TextEditingController();

  TextEditingController _renameTextEditingController = TextEditingController();
  TextEditingController _ttlTextEditingController = TextEditingController();

  TextEditingController _filterTextEditingController = TextEditingController();

  TextEditingController _selectedValueEditingController = TextEditingController();

  String panelUUID;
  NewConnectionData connection;
  String key;

  int pageIndex = 1;
  int scanCount = 20;

  @override
  void initState() {
    super.initState();
    _selectedValueEditingController.addListener(_selectedValueChanged);
  }


  void _selectedValueChanged() {
    context.read<DatabasePanelBloc>().add(ListSelectedValueChanged(_selectedValueEditingController.text));
  }

  StreamSubscription keyDetailStreamSubscription;
  @override
  void didInitState() {
    keyDetailStreamSubscription = BlocProvider.of<DatabasePanelBloc>(context).listen((DatabasePanelData data) {
      if(mounted && data != null && data.keyDetail != null && data.keyDetail is ListKeyDetail) {
        ListKeyDetail keyDetail = data.keyDetail;
        _keyEditingController.text = keyDetail.key;
        _renameTextEditingController.text = keyDetail.key;
        _ttlTextEditingController.text = "${keyDetail.ttl}";
      }
    });
    DatabasePanelData data = context.read<DatabasePanelBloc>().state;
    key = data.keyDetail.key;
    panelUUID = data.panelUUID;
    connection = data.connection;
    ListKeyDetail keyDetail = data.keyDetail;
    pageIndex = keyDetail.pageIndex;
    _keyEditingController.text = keyDetail.key;
    _renameTextEditingController.text = keyDetail.key;
    _ttlTextEditingController.text = "${keyDetail.ttl}";
  }

  @override
  void dispose() {
    super.dispose();
    _selectedValueEditingController?.removeListener(_selectedValueChanged);

    keyDetailStreamSubscription?.cancel();
    _keyEditingController?.dispose();
    _renameTextEditingController?.dispose();
    _ttlTextEditingController?.dispose();
    _filterTextEditingController?.dispose();
    _selectedValueEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
      builder: (context, state) {
        ListKeyDetail keyDetail = state.keyDetail;
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
            StringUtil.isNotBlank(keyDetail.selectedValue) ? Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _selectedValueEditingController,
                maxLines: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "VALUE",
                ),
              ),
            )) : Container(),
            StringUtil.isNotBlank(keyDetail.selectedValue) ? Offstage(
              offstage: StringUtil.isEqual(keyDetail.selectedValue, _selectedValueEditingController.text),
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 8, bottom: 8,),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Redis.instance.execute(connection.id, panelUUID, "lrange $key ${getPosition(keyDetail.selectedIndex)} ${getPosition(keyDetail.selectedIndex)}").then((value) {
                      String currentValue = value[0];
                      if(StringUtil.isEqual(keyDetail.selectedValue, currentValue)) {
                        return Redis.instance.execute(connection.id, panelUUID, "lset $key ${getPosition(keyDetail.selectedIndex)} ${_selectedValueEditingController.text}");
                      } else {
                        throw  "数据已变更，请刷新！";
                      }
                    }).then((value) {
                      if(StringUtil.isEqual("OK", value)) {
                        context.read<DatabasePanelBloc>().add(ListNewSelectedValue(_selectedValueEditingController.text));
                        BotToast.showText(text: "已更新。");
                      } else {
                        throw "更新失败！$value";
                      }
                    }).catchError((e) {
                      BotToast.showText(text: "$e");
                    });
                  },
                  child: Text("更新"),
                ),
              ),
            ) : Container(),
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
          ListKeyDetail keyDetail = state.keyDetail;
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
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: 150,
                            color: Colors.blueGrey,
                            child: Center(child: Text("ROW")),
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
                              0: FixedColumnWidth(150),
                              1: FlexColumnWidth(2),
                            },
                            border: TableBorder.all(),
                            children: _listValueRow(keyDetail),
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

  List<TableRow> _listValueRow(ListKeyDetail keyDetail) {
    if(keyDetail.rangeList == null || keyDetail.rangeList.isEmpty) {
      return [];
    }
    int counter = 1;
    return keyDetail.rangeList.asMap().map((index, element) {
      return MapEntry(index, TableRow(
          decoration: BoxDecoration(
              color: keyDetail.selectedIndex == index ? Colors.greenAccent.withAlpha(128) : Colors.blueGrey.withAlpha(128)
          ),
          children: [
            GestureDetector(
              onTap: () => _onValueSelected(index, element),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("${counter++}")),
              ),
            ),
            GestureDetector(
              onTap: () => _onValueSelected(index, element),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("$element")),
              ),
            ),
          ]
      ));
    }).values.toList();
  }

  void _onValueSelected(int index, String value) {
    _selectedValueEditingController.text = value;
    context.read<DatabasePanelBloc>().add(ListSelectedValue(index, value));
  }

  String tmpValue = "";

  Widget _controlKeyValuePanel() {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
        buildWhen: (previous, current) {
          return previous.keyDetail != current.keyDetail;
        },
        builder: (context, state) {
          ListKeyDetail keyDetail = state.keyDetail;
          return Container(
            width: 200,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Total: ${keyDetail.llen} / Page: ${keyDetail.rangeList?.length??0}"),
                        ),
                        MaterialButton(
                          color: Colors.blueAccent.withAlpha(128),
                          onPressed: () async {
                            int llen = await Redis.instance.execute(connection.id, panelUUID, "llen $key");
                            List lrangeList = await Redis.instance.execute(connection.id, panelUUID, "lrange $key 0 $scanCount");
                            List<String> valueList = List.of(lrangeList).map((e) => "$e").toList();

                            context.read<DatabasePanelBloc>().add(ListRefresh(llen, 1, valueList));
                            setState(() {
                              pageIndex = 1;
                            });
                            BotToast.showText(text: "已刷新。");
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
                          onPressed: () async {
                            List result = await showListValueDialog(
                              context,
                              connection.id,
                              panelUUID,
                              keyDetail.key,
                              tmpValue: tmpValue,
                            );
                            if(result != null && result.isNotEmpty) {
                              bool saveResult = result[0];
                              tmpValue = result[1];
                              if(saveResult??false) {
                                context.read<DatabasePanelBloc>().add(ListNewValue(tmpValue));
                                _selectedValueEditingController.text = tmpValue;
                                tmpValue = "";
                              }
                            }
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
                            if(StringUtil.isNotBlank(keyDetail.selectedValue)) {
                              NDialog(
                                dialogStyle: DialogStyle(titleDivider: true),
                                title: Text("删除 KEY"),
                                content: SizedBox(
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Text(
                                      "确定删除【${keyDetail.selectedValue}】？"
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
                                  Redis.instance.execute(connection.id, panelUUID, "lrange $key ${getPosition(keyDetail.selectedIndex)} ${getPosition(keyDetail.selectedIndex)}").then((value) {
                                    String currentValue = value[0];
                                    if(StringUtil.isEqual(keyDetail.selectedValue, currentValue)) {
                                      return Redis.instance.execute(connection.id, panelUUID, "lset $key ${getPosition(keyDetail.selectedIndex)} ---VALUE_REMOVED_BY_REDIS_HOUSE---");
                                    } else {
                                      throw  "数据已变更，请刷新！";
                                    }
                                  }).then((value) {
                                    if(StringUtil.isEqual("OK", value)) {
                                      return Redis.instance.execute(connection.id, panelUUID, "lrem $key 0 ---VALUE_REMOVED_BY_REDIS_HOUSE---");
                                    } else {
                                      throw "LSET 失败！$value";
                                    }
                                  }).then((value) {
                                    if(value == 1) {
                                      context.read<DatabasePanelBloc>().add(ListSelectedValueDeleted(keyDetail.selectedValue));
                                      BotToast.showText(text: "已删除。");
                                    } else {
                                      throw "删除失败！$value";
                                    }
                                  }).catchError((e) {
                                    BotToast.showText(text: "$e");
                                  });
                                }
                              });
                            } else {
                              BotToast.showText(text: "未选中 VALUE！");
                            }
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
                          controller: _filterTextEditingController,
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
                Row(
                  children: [
                    // Expanded(child:  navScanIndex <= 0 ? Container() : MaterialButton(
                    //     onPressed: () {
                    //       navScanIndex--;
                    //       scanKeyValueMap();
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Icon(Icons.arrow_back),
                    //     )
                    // )),
                    // Expanded(child: (navScanIndex >= navScanIndexList.length-1 || navScanIndexList[navScanIndex+1] == 0) ? Container() : MaterialButton(
                    //     onPressed: () {
                    //       navScanIndex++;
                    //       scanKeyValueMap();
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Icon(Icons.arrow_forward),
                    //     )
                    // )),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

  int getPosition(int index) {
    return (pageIndex-1) * scanCount+index;
  }

}