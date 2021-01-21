
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pigment/pigment.dart';
import 'package:redis_house/generated/l10n.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

Future<T> showHashValueDialog<T>(
    BuildContext context,
    String connectionId,
    String sessionId,
    String key,
    {
      bool autoPop = true,
      String tmpKey,
      String tmpValue,
    }
    ) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) {
    GlobalKey<_HashNewValueFormState> _newHashKeyFormKey = new GlobalKey<_HashNewValueFormState>();
    return SimpleDialog(
        contentPadding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/4*3,
            child: Column(
              children: [
                Container(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("添加行", style: TextStyle(fontSize: 20),),
                  )),
                ),
                Container(height: 0.2, color: Pigment.fromString("#FEFEFE"),),
                Expanded(child: _HashNewValueForm(_newHashKeyFormKey, connectionId, sessionId, key, tmpKey, tmpValue)),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                List keyValue = _newHashKeyFormKey.currentState.keyValue();
                                if(autoPop) Navigator.pop(context, [false, ...keyValue]);
                              },
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: Text(S.of(context).cancelLabel, style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                              )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                bool saveResult = await _newHashKeyFormKey.currentState.doSave();
                                List keyValue = _newHashKeyFormKey.currentState.keyValue();
                                if(autoPop) Navigator.pop(context, [saveResult, ...keyValue]);
                              },
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: Text(S.of(context).saveLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]
    );
  }
);

Future<T> showListValueDialog<T>(
    BuildContext context,
    String connectionId,
    String sessionId,
    String key,
    {
      bool autoPop = true,
      String tmpValue,
    }
    ) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      GlobalKey<_ListNewValueFormState> _newListValueFormKey = new GlobalKey<_ListNewValueFormState>();
      return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                children: [
                  Container(
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("添加行", style: TextStyle(fontSize: 20),),
                    )),
                  ),
                  Container(height: 0.2, color: Pigment.fromString("#FEFEFE"),),
                  Expanded(child: _ListNewValueForm(_newListValueFormKey, connectionId, sessionId, key, tmpValue)),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String value = _newListValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [false, value]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).cancelLabel, style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  bool saveResult = await _newListValueFormKey.currentState.doSave();
                                  String value = _newListValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [saveResult, value]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).saveLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]
      );
    }
);

Future<T> showSetValueDialog<T>(
    BuildContext context,
    String connectionId,
    String sessionId,
    String key,
    {
      bool autoPop = true,
      String tmpValue,
    }
    ) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      GlobalKey<_SetNewValueFormState> _newSetValueFormKey = new GlobalKey<_SetNewValueFormState>();
      return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                children: [
                  Container(
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("添加行", style: TextStyle(fontSize: 20),),
                    )),
                  ),
                  Container(height: 0.2, color: Pigment.fromString("#FEFEFE"),),
                  Expanded(child: _SetNewValueForm(_newSetValueFormKey, connectionId, sessionId, key, tmpValue)),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String value = _newSetValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [false, value]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).cancelLabel, style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  bool saveResult = await _newSetValueFormKey.currentState.doSave();
                                  String value = _newSetValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [saveResult, value]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).saveLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]
      );
    }
);

Future<T> showZSetValueDialog<T>(
    BuildContext context,
    String connectionId,
    String sessionId,
    String key,
    {
      bool autoPop = true,
      String tmpScore,
      String tmpValue,
    }
    ) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      GlobalKey<_ZSetNewValueFormState> _newZSetValueFormKey = new GlobalKey<_ZSetNewValueFormState>();
      return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                children: [
                  Container(
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("添加行", style: TextStyle(fontSize: 20),),
                    )),
                  ),
                  Container(height: 0.2, color: Pigment.fromString("#FEFEFE"),),
                  Expanded(child: _ZSetNewValueForm(_newZSetValueFormKey, connectionId, sessionId, key, tmpScore, tmpValue)),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  List<String> valueList = _newZSetValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [false, ...valueList]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).cancelLabel, style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  bool saveResult = await _newZSetValueFormKey.currentState.doSave();
                                  List<String> valueList = _newZSetValueFormKey.currentState.value();
                                  if(autoPop) Navigator.pop(context, [saveResult, ...valueList]);
                                },
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Text(S.of(context).saveLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]
      );
    }
);

class _HashNewValueForm extends StatefulWidget {
  final String connectionId;
  final String sessionId;
  final String selectedKey;
  final String tmpKey;
  final String tmpValue;
  _HashNewValueForm(Key key, this.connectionId, this.sessionId, this.selectedKey, this.tmpKey, this.tmpValue) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HashNewValueFormState();
  }
}

class _HashNewValueFormState extends State<_HashNewValueForm> {

  TextEditingController _keyEditingController = TextEditingController();
  TextEditingController _valueEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _keyEditingController.text = widget.tmpKey;
    _valueEditingController.text = widget.tmpValue;
  }

  @override
  void dispose() {
    _keyEditingController?.dispose();
    _valueEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _keyEditingController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "输入 KEY：",
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: TextField(
              controller: _valueEditingController,
              maxLines: 200,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "输入 VALUE：",
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> keyValue() => [
    _keyEditingController.text,
    _valueEditingController.text,
  ];

  Future<bool> doSave() async {
    if(StringUtil.isBlank(_keyEditingController.text)) {
      BotToast.showText(text: "KEY 不能为空！");
      return false;
    }
    if(StringUtil.isBlank(_valueEditingController.text)) {
      BotToast.showText(text: "VALUE 不能为空！");
      return false;
    }
    try {
      int result = await Redis.instance.execute(widget.connectionId, widget.sessionId, "hset ${widget.selectedKey} ${_keyEditingController.text} ${_valueEditingController.text}");
      if(result == 1) {
        BotToast.showText(text: "已保存。");
        return true;
      } else {
        BotToast.showText(text: "保存失败！$result");
        return false;
      }
    } catch (e) {
      BotToast.showText(text: "保存失败！$e");
      return false;
    }

  }

}

class _ListNewValueForm extends StatefulWidget {
  final String connectionId;
  final String sessionId;
  final String selectedKey;
  final String tmpValue;
  _ListNewValueForm(Key key, this.connectionId, this.sessionId, this.selectedKey, this.tmpValue) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ListNewValueFormState();
  }
}

class _ListNewValueFormState extends State<_ListNewValueForm> {

  TextEditingController _valueEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueEditingController.text = widget.tmpValue;
  }

  @override
  void dispose() {
    _valueEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _valueEditingController,
              maxLines: 200,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "输入 VALUE：",
              ),
            ),
          ),
        ],
      ),
    );
  }

  String value() => _valueEditingController.text;

  Future<bool> doSave() async {
    if(StringUtil.isBlank(_valueEditingController.text)) {
      BotToast.showText(text: "VALUE 不能为空！");
      return false;
    }
    try {
      int result = await Redis.instance.execute(widget.connectionId, widget.sessionId, "lpush ${widget.selectedKey} ${_valueEditingController.text}");
      if(result != -1) {
        BotToast.showText(text: "已保存。");
        return true;
      } else {
        BotToast.showText(text: "保存失败！$result");
        return false;
      }
    } catch (e) {
      BotToast.showText(text: "保存失败！$e");
      return false;
    }

  }

}

class _SetNewValueForm extends StatefulWidget {
  final String connectionId;
  final String sessionId;
  final String selectedKey;
  final String tmpValue;
  _SetNewValueForm(Key key, this.connectionId, this.sessionId, this.selectedKey, this.tmpValue) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SetNewValueFormState();
  }
}

class _SetNewValueFormState extends State<_SetNewValueForm> {

  TextEditingController _valueEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueEditingController.text = widget.tmpValue;
  }

  @override
  void dispose() {
    _valueEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _valueEditingController,
              maxLines: 200,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "输入 VALUE：",
              ),
            ),
          ),
        ],
      ),
    );
  }

  String value() => _valueEditingController.text;

  Future<bool> doSave() async {
    if(StringUtil.isBlank(_valueEditingController.text)) {
      BotToast.showText(text: "VALUE 不能为空！");
      return false;
    }
    try {
      int result = await Redis.instance.execute(widget.connectionId, widget.sessionId, "sadd ${widget.selectedKey} ${_valueEditingController.text}");
      if(result != -1) {
        BotToast.showText(text: "已保存。");
        return true;
      } else {
        BotToast.showText(text: "保存失败！$result");
        return false;
      }
    } catch (e) {
      BotToast.showText(text: "保存失败！$e");
      return false;
    }

  }

}

class _ZSetNewValueForm extends StatefulWidget {
  final String connectionId;
  final String sessionId;
  final String selectedKey;
  final String tmpScore;
  final String tmpValue;
  _ZSetNewValueForm(Key key, this.connectionId, this.sessionId, this.selectedKey, this.tmpScore, this.tmpValue) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ZSetNewValueFormState();
  }
}

class _ZSetNewValueFormState extends State<_ZSetNewValueForm> {

  TextEditingController _scoreEditingController = TextEditingController();
  TextEditingController _valueEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scoreEditingController.text = widget.tmpScore;
    _valueEditingController.text = widget.tmpValue;
  }

  @override
  void dispose() {
    _scoreEditingController?.dispose();
    _valueEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _scoreEditingController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "输入 SCORE：",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),//只允许输入小数
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: TextField(
              controller: _valueEditingController,
              maxLines: 200,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "输入 VALUE：",
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> value() => [_scoreEditingController.text, _valueEditingController.text];

  Future<bool> doSave() async {
    if(StringUtil.isBlank(_scoreEditingController.text)) {
      BotToast.showText(text: "SCORE 不能为空！");
      return false;
    }
    if(StringUtil.isBlank(_valueEditingController.text)) {
      BotToast.showText(text: "VALUE 不能为空！");
      return false;
    }
    try {
      int result = await Redis.instance.execute(widget.connectionId, widget.sessionId, "zadd ${widget.selectedKey} ${_scoreEditingController.text} ${_valueEditingController.text}");
      if(result != -1) {
        BotToast.showText(text: "已保存。");
        return true;
      } else {
        BotToast.showText(text: "保存失败！$result");
        return false;
      }
    } catch (e) {
      BotToast.showText(text: "保存失败！$e");
      return false;
    }

  }

}