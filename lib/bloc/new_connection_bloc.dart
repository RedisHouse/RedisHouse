
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/util/string_util.dart';

class NewConnectionBloc extends BaseBloc<NewConnectionEvent, NewConnectionData> {

  NewConnectionBloc(BuildContext context, NewConnectionData initialState) : super(context, initialState);

  @override
  Stream<NewConnectionData> mapEventToState(event) async* {
    if(event is NewConnectionChangedEvent) {
      yield state.rebuild((b) {
        if(StringUtil.isNotBlank(event.redisName)) {
          b.redisName = event.redisName;
        }
        if(StringUtil.isNotBlank(event.redisAddress)) {
          b.redisAddress = event.redisAddress;
        }
        if(StringUtil.isNotBlank(event.redisPort)) {
          b.redisPort = event.redisPort;
        }
        if(StringUtil.isNotBlank(event.redisPassword)) {
          b.redisPassword = event.redisPassword;
        }
        if(StringUtil.isNotBlank(event.sshAddress)) {
          b.sshAddress = event.sshAddress;
        }
        if(StringUtil.isNotBlank(event.sshPort)) {
          b.sshPort = event.sshPort;
        }
        if(StringUtil.isNotBlank(event.sshUser)) {
          b.sshUser = event.sshUser;
        }
        if(StringUtil.isNotBlank(event.sshPrivateKey)) {
          b.sshPrivateKey = event.sshPrivateKey;
        }
        if(StringUtil.isNotBlank(event.sshPassword)) {
          if(state.useSSHPrivateKey) {
            b.sshPrivateKeyPassword = event.sshPassword;
          } else {
            b.sshPassword = event.sshPassword;
          }
        }
      });
    } else if(event is NewConnectionChangeSwitchEvent) {
      yield state.rebuild((b) {
        if(event.useSSLTLS != null) {
          b.useSSLTLS = event.useSSLTLS;
          if(event.useSSLTLS) {
            b.useSSHTunnel = false;
          }
        }
        if(event.useSSHTunnel != null) {
          b.useSSHTunnel = event.useSSHTunnel;
          if(event.useSSHTunnel) {
            b.useSSLTLS = false;
          }
        }
        if(event.useSSHPrivateKey != null) {
          b.useSSHPrivateKey = event.useSSHPrivateKey;
          if(event.useSSHPrivateKey) {
            b.sshPassword = null;
          } else {
            b.sshPrivateKeyPassword = null;
          }
        }
      });
    }
  }

}

abstract class NewConnectionEvent {}

class NewConnectionChangedEvent extends NewConnectionEvent {
  String redisName;
  String redisAddress;
  String redisPort;
  String redisPassword;
  String sshAddress;
  String sshPort;
  String sshUser;
  String sshPassword;
  String sshPrivateKey;

  NewConnectionChangedEvent({
    this.redisName,
    this.redisAddress,
    this.redisPort,
    this.redisPassword,
    this.sshAddress,
    this.sshPort,
    this.sshUser,
    this.sshPassword,
    this.sshPrivateKey,
  });
}

class NewConnectionChangeSwitchEvent extends NewConnectionEvent {
  bool useSSLTLS;
  bool useSSHTunnel;
  bool useSSHPrivateKey;
  NewConnectionChangeSwitchEvent({
    this.useSSLTLS,
    this.useSSHTunnel,
    this.useSSHPrivateKey,
  });
}