
import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/new_connection_bloc.dart';
import 'package:redis_house/generated/l10n.dart';
import 'package:redis_house/util/string_util.dart';

Future<T> newConnectionDialog<T>(BuildContext context, {bool autoPop = true,}) => showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => SimpleDialog(
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
              child: _ConnectionInfoForm(),
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
                        onTap: () {

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
                        onTap: () {
                          if(autoPop) Navigator.pop(context);
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
  )
);

class _ConnectionInfoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConnectionInfoFormState();
  }
}

class _ConnectionInfoFormState extends State<_ConnectionInfoForm> with AfterInitMixin<_ConnectionInfoForm> {

  TextEditingController _redisNameEditingController;
  TextEditingController _redisAddressEditingController;
  TextEditingController _redisPortEditingController;
  TextEditingController _redisPasswordEditingController;

  TextEditingController _sshAddressEditingController;
  TextEditingController _sshPortEditingController;
  TextEditingController _sshUserEditingController;
  TextEditingController _sshPrivateKeyEditingController;
  TextEditingController _sshPasswordEditingController;

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
    _sshPrivateKeyEditingController = TextEditingController();
    _sshPasswordEditingController   = TextEditingController();

    _redisNameEditingController.addListener(redisNameChanged);
    _redisAddressEditingController.addListener(redisAddressChanged);
    _redisPortEditingController.addListener(redisPortChanged);
    _redisPasswordEditingController.addListener(redisPasswordChanged);
    _sshAddressEditingController.addListener(sshAddressChanged);
    _sshPortEditingController.addListener(sshPortChanged);
    _sshUserEditingController.addListener(sshUserChanged);
    _sshPrivateKeyEditingController.addListener(sshPrivateKeyChanged);
    _sshPasswordEditingController.addListener(sshPasswordChanged);
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

  void sshPrivateKeyChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPrivateKey: _sshPrivateKeyEditingController.text.trim()
    ));
  }

  void sshPasswordChanged() {
    context.read<NewConnectionBloc>().add(NewConnectionChangedEvent(
        sshPassword: _sshPasswordEditingController.text.trim()
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
      _sshPasswordEditingController.text = newConnectionState.sshPrivateKeyPassword;
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
    _sshPrivateKeyEditingController?.removeListener(sshPrivateKeyChanged);
    _sshPasswordEditingController?.removeListener(sshPasswordChanged);

    _redisNameEditingController?.dispose();
    _redisAddressEditingController?.dispose();
    _redisPortEditingController?.dispose();
    _redisPasswordEditingController?.dispose();
    _sshAddressEditingController?.dispose();
    _sshPortEditingController?.dispose();
    _sshUserEditingController?.dispose();
    _sshPrivateKeyEditingController?.dispose();
    _sshPasswordEditingController?.dispose();
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
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: TextField(
                    controller: _redisNameEditingController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      border: const OutlineInputBorder(),
                      labelText: S.of(context).connectionNameLabel,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextField(
                          controller: _redisAddressEditingController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            border: const OutlineInputBorder(),
                            labelText: S.of(context).connectionAddressLabel,
                            hintText: "127.0.0.1",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: TextField(
                          controller: _redisPortEditingController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            border: const OutlineInputBorder(),
                            labelText: S.of(context).connectionPortLabel,
                            hintText: "6379",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: TextField(
                    controller: _redisPasswordEditingController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      border: const OutlineInputBorder(),
                      labelText: S.of(context).connectionPasswordLabel
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
                          // setState(() {
                          //   useSSLTLS = value;
                          //   if(value) {
                          //     useSSHTunnel = false;
                          //   }
                          // });
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
                        // setState(() {
                        //   useSSHTunnel = value;
                        //   if(value) {
                        //     useSSLTLS = false;
                        //   }
                        // });
                      }),
                      Text("SSH Tunnel")
                    ],
                  ),
                ),
                ...sshTunnelWidgets(state)
              ],
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
              child: TextField(
                controller: _sshAddressEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(),
                  labelText: "SSH Address",
                  hintText: "127.0.0.1",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 8.0),
              child: TextField(
                controller: _sshPortEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 0),
                  border: const OutlineInputBorder(),
                  labelText: "SSH Port",
                  hintText: "22",
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: TextField(
          controller: _sshUserEditingController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 0),
              border: const OutlineInputBorder(),
              labelText: "SSH User"
          ),
        ),
      ),
      Container(
        child: Row(
          children: [
            Switch(value: state.useSSHPrivateKey, onChanged: (value) {
              changeSwitch(useSSHPrivateKey: value);
              _sshPasswordEditingController.clear();
            }),
            Text("Private Key")
          ],
        ),
      ),
      state.useSSHPrivateKey ? Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Stack(
          children: [
            TextField(
              enabled: false,
              controller: _sshPrivateKeyEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 0),
                border: const OutlineInputBorder(),
                labelText: "Select Private Key",
              ),
            ),
            Positioned(
              right: 10,

              child: FlatButton(
                color: Colors.lightBlue,
                padding: EdgeInsets.zero,
                onPressed: () {
                  BotToast.showText(text: "选择文件");
                },
                child: Text("选择文件"),
              ),
            )
          ],
        ),
      ) : Container(),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: TextField(
          controller: _sshPasswordEditingController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 0),
              border: const OutlineInputBorder(),
              labelText: state.useSSHPrivateKey ? "Private Key Password" : "SSH Password"
          ),
        ),
      ),
    ];
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