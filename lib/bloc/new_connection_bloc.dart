
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';

class NewConnectionBloc extends BaseBloc<NewConnectionEvent, NewConnectionData> {

  NewConnectionBloc(BuildContext context, NewConnectionData initialState) : super(context, initialState);

  @override
  Stream<NewConnectionData> mapEventToState(event) async* {
    if(event is NewConnectionChangedEvent) {
      yield state.rebuild((b) {
        if(event.redisName != null) {
          b.redisName = event.redisName;
        }
        if(event.redisAddress != null) {
          b.redisAddress = event.redisAddress;
        }
        if(event.redisPort != null) {
          b.redisPort = event.redisPort;
        }
        if(event.redisPassword != null) {
          b.redisPassword = event.redisPassword;
        }
        if(event.sshAddress != null) {
          b.sshAddress = event.sshAddress;
        }
        if(event.sshPort != null) {
          b.sshPort = event.sshPort;
        }
        if(event.sshUser != null) {
          b.sshUser = event.sshUser;
        }
        if(event.sshPassword != null) {
          b.sshPassword = event.sshPassword;
        }
        if(event.sshPrivateKey != null) {
          b.sshPrivateKey = event.sshPrivateKey;
        }
        if(event.sshPrivateKeyPassword != null) {
          b.sshPrivateKeyPassword = event.sshPrivateKeyPassword;
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
        }
      });
    } else if(event is ClearConnectionContentEvent) {
      yield state.rebuild((b) => b..replace(NewConnectionData((b) => b..useSSLTLS=false..useSSHTunnel=false..useSSHPrivateKey=false)));
    } else if(event is EditConnectionEvent) {
      yield state.rebuild((b) {
        b.id = event.connectionData.id;
        b.redisName = event.connectionData.redisName??"";
        b.redisAddress = event.connectionData.redisAddress??"";
        b.redisPort = event.connectionData.redisPort??"";
        b.redisPassword = event.connectionData.redisPassword??"";
        b.sshAddress = event.connectionData.sshAddress??"";
        b.sshPort = event.connectionData.sshPort??"";
        b.sshUser = event.connectionData.sshUser??"";
        b.sshPassword = event.connectionData.sshPassword??"";
        b.sshPrivateKey = event.connectionData.sshPrivateKey??"";
        b.sshPrivateKeyPassword = event.connectionData.sshPrivateKeyPassword??"";
        b.useSSLTLS = event.connectionData.useSSLTLS;
        b.useSSHTunnel = event.connectionData.useSSHTunnel;
        b.useSSHPrivateKey = event.connectionData.useSSHPrivateKey;
      });
    } else if(event is CopyConnectionEvent) {
      yield state.rebuild((b) {
        b.redisName = event.connectionData.redisName??"";
        b.redisAddress = event.connectionData.redisAddress??"";
        b.redisPort = event.connectionData.redisPort??"";
        b.redisPassword = event.connectionData.redisPassword??"";
        b.sshAddress = event.connectionData.sshAddress??"";
        b.sshPort = event.connectionData.sshPort??"";
        b.sshUser = event.connectionData.sshUser??"";
        b.sshPassword = event.connectionData.sshPassword??"";
        b.sshPrivateKey = event.connectionData.sshPrivateKey??"";
        b.sshPrivateKeyPassword = event.connectionData.sshPrivateKeyPassword??"";
        b.useSSLTLS = event.connectionData.useSSLTLS;
        b.useSSHTunnel = event.connectionData.useSSHTunnel;
        b.useSSHPrivateKey = event.connectionData.useSSHPrivateKey;
      });
    }
  }

}

abstract class NewConnectionEvent {}

class ClearConnectionContentEvent extends NewConnectionEvent{}

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
  String sshPrivateKeyPassword;

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
    this.sshPrivateKeyPassword,
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

class EditConnectionEvent extends NewConnectionEvent {
  NewConnectionData connectionData;
  EditConnectionEvent(this.connectionData);
}

class CopyConnectionEvent extends NewConnectionEvent {
  NewConnectionData connectionData;
  CopyConnectionEvent(this.connectionData);
}