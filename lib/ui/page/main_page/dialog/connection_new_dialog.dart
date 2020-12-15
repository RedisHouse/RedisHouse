
import 'dart:convert';
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/new_connection_bloc.dart';
import 'package:redis_house/generated/l10n.dart';
import 'package:redis_house/plugin/file_picker/file_picker.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/router/application.dart';
import 'package:redis_house/util/string_util.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

Future<T> newConnectionDialog<T>(BuildContext context, {bool autoPop = true,}) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) {
    GlobalKey<_ConnectionInfoFormState> _connectionInfoKey = new GlobalKey<_ConnectionInfoFormState>();
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
                child: Text(S.of(context).newConnectionLabel, style: TextStyle(fontSize: 20),),
              )),
            ),
            Container(height: 0.2, color: Pigment.fromString("#FEFEFE"),),
            Expanded(child: Container(
              child: _ConnectionInfoForm(_connectionInfoKey),
            )),
            Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          await _connectionInfoKey.currentState.doTest();
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Text(S.of(context).testConnectionLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                        )),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          context.read<NewConnectionBloc>().add(ClearConnectionContentEvent());
                          Navigator.pop(context);
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Text("清空", style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if(autoPop) Navigator.pop(context);
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Text(S.of(context).cancelLabel, style: TextStyle(color: Pigment.fromString("#484848"), fontSize: 14, fontWeight: FontWeight.bold),),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    color: Colors.white,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          bool saved = await _connectionInfoKey.currentState.doSave();
                          if(saved) {
                            Navigator.pop(context);
                          }
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Text(S.of(context).saveLabel, style: TextStyle(color: Pigment.fromString("#4E80F7"), fontSize: 14, fontWeight: FontWeight.bold),),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
  }
);

class _ConnectionInfoForm extends StatefulWidget {
  _ConnectionInfoForm(Key key) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ConnectionInfoFormState();
  }
}

class _ConnectionInfoFormState extends State<_ConnectionInfoForm> with AfterInitMixin<_ConnectionInfoForm> {

  GlobalKey<FormState> _formKey= new GlobalKey<FormState>();

  TextEditingController _redisNameEditingController;
  TextEditingController _redisAddressEditingController;
  TextEditingController _redisPortEditingController;
  TextEditingController _redisPasswordEditingController;

  TextEditingController _sshAddressEditingController;
  TextEditingController _sshPortEditingController;
  TextEditingController _sshUserEditingController;
  TextEditingController _sshPasswordEditingController;
  TextEditingController _sshPrivateKeyEditingController;
  TextEditingController _sshPrivateKeyPasswordEditingController;

  bool hideRedisPassword = true;
  bool hideSSHPassword = true;
  bool hideSSHPrivateKeyPassword = true;

  @override
  void initState() {
    super.initState();
    _redisNameEditingController     = TextEditingController();
    _redisAddressEditingController  = TextEditingController();
    _redisPortEditingController     = TextEditingController(text: "6379");
    _redisPasswordEditingController = TextEditingController();

    _sshAddressEditingController    = TextEditingController();
    _sshPortEditingController       = TextEditingController(text: "22");
    _sshUserEditingController       = TextEditingController();
    _sshPasswordEditingController   = TextEditingController();
    _sshPrivateKeyEditingController = TextEditingController();
    _sshPrivateKeyPasswordEditingController   = TextEditingController();

    _redisNameEditingController.addListener(redisNameChanged);
    _redisAddressEditingController.addListener(redisAddressChanged);
    _redisPortEditingController.addListener(redisPortChanged);
    _redisPasswordEditingController.addListener(redisPasswordChanged);
    _sshAddressEditingController.addListener(sshAddressChanged);
    _sshPortEditingController.addListener(sshPortChanged);
    _sshUserEditingController.addListener(sshUserChanged);
    _sshPasswordEditingController.addListener(sshPasswordChanged);
    _sshPrivateKeyEditingController.addListener(sshPrivateKeyChanged);
    _sshPrivateKeyPasswordEditingController.addListener(sshPrivateKeyPasswordChanged);
  }
  
  void redisNameChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
      redisName: _redisNameEditingController.text.trim()
    ));
  }

  void redisAddressChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        redisAddress: _redisAddressEditingController.text.trim()
    ));
  }

  void redisPortChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        redisPort: _redisPortEditingController.text.trim()
    ));
  }

  void redisPasswordChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        redisPassword: _redisPasswordEditingController.text.trim()
    ));
  }

  void sshAddressChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshAddress: _sshAddressEditingController.text.trim()
    ));
  }

  void sshPortChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPort: _sshPortEditingController.text.trim()
    ));
  }

  void sshUserChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshUser: _sshUserEditingController.text.trim()
    ));
  }

  void sshPasswordChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPassword: _sshPasswordEditingController.text.trim()
    ));
  }

  void sshPrivateKeyChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPrivateKey: _sshPrivateKeyEditingController.text.trim()
    ));
  }

  void sshPrivateKeyPasswordChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPrivateKeyPassword: _sshPrivateKeyPasswordEditingController.text.trim()
    ));
  }

  @override
  void didInitState() {
    var newConnectionState = context.read<NewConnectionBloc>().state;
    if(StringUtil.isNotBlank(newConnectionState.redisName)) {
      _redisNameEditingController.text = newConnectionState.redisName;
    }
    if(StringUtil.isNotBlank(newConnectionState.redisAddress)) {
      _redisAddressEditingController.text = newConnectionState.redisAddress;
    }
    if(StringUtil.isNotBlank(newConnectionState.redisPort)) {
      _redisPortEditingController.text = newConnectionState.redisPort;
    }
    if(StringUtil.isNotBlank(newConnectionState.redisPassword)) {
      _redisPasswordEditingController.text = newConnectionState.redisPassword;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshAddress)) {
      _sshAddressEditingController.text = newConnectionState.sshAddress;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshPort)) {
      _sshPortEditingController.text = newConnectionState.sshPort;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshUser)) {
      _sshUserEditingController.text = newConnectionState.sshUser;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshPassword)) {
      _sshPasswordEditingController.text = newConnectionState.sshPassword;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshPrivateKey)) {
      _sshPrivateKeyEditingController.text = newConnectionState.sshPrivateKey;
    }
    if(StringUtil.isNotBlank(newConnectionState.sshPrivateKeyPassword)) {
      _sshPrivateKeyPasswordEditingController.text = newConnectionState.sshPrivateKeyPassword;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _redisNameEditingController?.removeListener(redisNameChanged);
    _redisAddressEditingController?.removeListener(redisAddressChanged);
    _redisPortEditingController?.removeListener(redisPortChanged);
    _redisPasswordEditingController?.removeListener(redisPasswordChanged);
    _sshAddressEditingController?.removeListener(sshAddressChanged);
    _sshPortEditingController?.removeListener(sshPortChanged);
    _sshUserEditingController?.removeListener(sshUserChanged);
    _sshPasswordEditingController?.removeListener(sshPasswordChanged);
    _sshPrivateKeyEditingController?.removeListener(sshPrivateKeyChanged);
    _sshPrivateKeyPasswordEditingController?.removeListener(sshPrivateKeyPasswordChanged);

    _redisNameEditingController?.dispose();
    _redisAddressEditingController?.dispose();
    _redisPortEditingController?.dispose();
    _redisPasswordEditingController?.dispose();
    _sshAddressEditingController?.dispose();
    _sshPortEditingController?.dispose();
    _sshUserEditingController?.dispose();
    _sshPasswordEditingController?.dispose();
    _sshPrivateKeyEditingController?.dispose();
    _sshPrivateKeyPasswordEditingController?.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NewConnectionBloc, NewConnectionData>(
          buildWhen: (previous, current) {
            return true;
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: _redisNameEditingController,
                      maxLength: 32,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        border: const OutlineInputBorder(),
                        labelText: "${S.of(context).connectionNameLabel}*",
                      ),
                      validator: (v) {
                        if(StringUtil.isBlank(v)) {
                          return "名称不能为空";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: TextFormField(
                            controller: _redisAddressEditingController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            maxLength: 255,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              border: const OutlineInputBorder(),
                              labelText: "${S.of(context).connectionAddressLabel}*",
                              hintText: "127.0.0.1",
                            ),
                            validator: (v) {
                              if(StringUtil.isBlank(v)) {
                                return "地址不能为空";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: TextFormField(
                            controller: _redisPortEditingController,
                            maxLength: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              border: const OutlineInputBorder(),
                              labelText: "${S.of(context).connectionPortLabel}*",
                              hintText: "6379",
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            validator: (v) {
                              if(StringUtil.isBlank(v)) {
                                return "端口不能为空";
                              }
                              int port = int.tryParse(v);
                              if(port == null || port <= 1 || port > 65535) {
                                return "端口不合法";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      controller: _redisPasswordEditingController,
                      obscureText: hideRedisPassword,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        suffixIcon: IconButton(
                          icon: Icon(hideRedisPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
                          onPressed: () {
                            setState(() {
                              hideRedisPassword = !hideRedisPassword;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        labelText: S.of(context).connectionPasswordLabel,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: true, // 隐藏
                    child: Container(
                      child: Row(
                        children: [
                          Switch(value: state.useSSLTLS, onChanged: (value) {
                            changeSwitch(useSSLTLS: value);
                          }),
                          Text("SSL / TLS")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Switch(value: state.useSSHTunnel, onChanged: (value) {
                          changeSwitch(useSSHTunnel: value);
                        }),
                        Text("SSH Tunnel")
                      ],
                    ),
                  ),
                  ...sshTunnelWidgets(state)
                ],
              ),
            );
          }
        ),
      ),
    );
  }
  
  List<Widget> sshTunnelWidgets(NewConnectionData state) {
    if(!state.useSSHTunnel) {
      return [];
    }
    return [
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
              child: TextFormField(
                controller: _sshAddressEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                maxLength: 255,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(),
                  labelText: "SSH Address*",
                  hintText: "127.0.0.1",
                ),
                validator: (v) {
                  if(StringUtil.isBlank(v)) {
                    return "地址不能为空";
                  }
                  return null;
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
              child: TextFormField(
                controller: _sshPortEditingController,
                maxLength: 5,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(),
                  labelText: "SSH Port*",
                  hintText: "22",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                validator: (v) {
                  if(StringUtil.isBlank(v)) {
                    return "端口不能为空";
                  }
                  int port = int.tryParse(v);
                  if(port == null || port <= 1 || port > 65535) {
                    return "端口不合法";
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: TextFormField(
          controller: _sshUserEditingController,
          maxLength: 32,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 0),
              border: const OutlineInputBorder(),
              labelText: "SSH User*"
          ),
          validator: (v) {
            if(StringUtil.isBlank(v)) {
              return "用户名不能为空";
            }
            return null;
          },
        ),
      ),
      Container(
        child: Row(
          children: [
            Switch(value: state.useSSHPrivateKey, onChanged: (value) {
              changeSwitch(useSSHPrivateKey: value);
            }),
            Text("Private Key")
          ],
        ),
      ),
      state.useSSHPrivateKey ? Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Stack(
          children: [
            TextFormField(
              enabled: false,
              controller: _sshPrivateKeyEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(),
                labelText: "Select Private Key*",
              ),
              validator: (v) {
                if(StringUtil.isBlank(v)) {
                  return "私钥文件不能为空";
                }
                return null;
              },
            ),
            Positioned(
              right: 10,
              child: FlatButton(
                color: Colors.lightBlue,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  var result = await FilePicker.instance.pickFile();
                  print("选中文件：$result");
                  _sshPrivateKeyEditingController.text = result;
                },
                child: Text("选择文件"),
              ),
            )
          ],
        ),
      ) : Container(),
      state.useSSHPrivateKey ? Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: TextFormField(
          controller: _sshPrivateKeyPasswordEditingController,
          obscureText: hideSSHPrivateKeyPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            suffixIcon: IconButton(
              icon: Icon(hideSSHPrivateKeyPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
              onPressed: () {
                setState(() {
                  hideSSHPrivateKeyPassword = !hideSSHPrivateKeyPassword;
                });
              },
            ),
            border: const OutlineInputBorder(),
            labelText: "Private Key Password",
          ),
        ),
      ) : Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: TextFormField(
          controller: _sshPasswordEditingController,
          obscureText: hideSSHPassword,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            suffixIcon: IconButton(
              icon: Icon(hideSSHPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded),
              onPressed: () {
                setState(() {
                  hideSSHPassword = !hideSSHPassword;
                });
              },
            ),
            border: const OutlineInputBorder(),
            labelText: "SSH Password",
          ),
        ),
      ),
    ];
  }

  Future doTest() async {
    if(_formKey.currentState.validate()) {
      var connectionInfo = context.read<NewConnectionBloc>().state;
      connectionInfo = connectionInfo.rebuild((b) {
        if(StringUtil.isBlank(b.redisPort)) {
          b.redisPort = "6379";
        }
        if(StringUtil.isBlank(b.sshPort)) {
          b.sshPort = "22";
        }
      });
      bool success = await Redis.instance.ping(connectionInfo.toJson());
      if(success) {
        BotToast.showText(text: "连接成功。");
      } else {
        BotToast.showText(text: "连接失败！");
      }
    }
  }

  Future<bool> doSave() async {
    if(_formKey.currentState.validate()) {
      var newConnectionBloc =context.read<NewConnectionBloc>();
      var newConnectionData = newConnectionBloc.state;
      newConnectionData = newConnectionData.rebuild((b) {
        b.id = Uuid().v1();
        if(StringUtil.isBlank(b.redisPort)) {
          b.redisPort = "6379";
        }
        if(StringUtil.isBlank(b.sshPort)) {
          b.sshPort = "22";
        }
      });
      await intMapStoreFactory.store("t_connection").add(Application.db, newConnectionData.toJson());
      newConnectionBloc.add(ClearConnectionContentEvent());
      newConnectionBloc.close();

      BotToast.showText(text: "已保存。");
      return Future.value(true);
    }
    return Future.value(false);
  }

  void changeSwitch({
    bool useSSLTLS,
    bool useSSHTunnel,
    bool useSSHPrivateKey,
  }) {
    context.read<NewConnectionBloc>().add(NewConnectionChangeSwitchEvent(
      useSSLTLS: useSSLTLS,
      useSSHTunnel: useSSHTunnel,
      useSSHPrivateKey: useSSHPrivateKey,
    ));
  }

}