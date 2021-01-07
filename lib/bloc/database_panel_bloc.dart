import 'package:flutter/material.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/log/log.dart';
import 'package:built_collection/built_collection.dart';
import 'package:redis_house/util/string_util.dart';


class DatabasePanelBloc extends BaseBloc<DatabasePanelEvent, DatabasePanelData> {

  DatabasePanelBloc(BuildContext context, DatabasePanelData initialState) : super(context, initialState);

  @override
  Stream<DatabasePanelData> mapEventToState(event) async* {
    if(event is SelectedKeyChanged) {
      yield state.rebuild((b) => b.selectedKey=event.selectedKey);
    } else if(event is ScanKeyListChanged) {
      yield state.rebuild((b) => b.scanKeyList=event.scanKeyList.toBuiltList().toBuilder());
    } else if(event is ScanKeyListClear) {
      yield state.rebuild((b) => b..selectedKey=""..scanKeyList.clear());
    } else if(event is KeyDetailChanged) {
      yield state.rebuild((b) => b..keyDetail=event.keyDetail);
    } else if(event is KeyTTLChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is StringKeyDetail) {
          StringKeyDetail stringKeyDetail = keyDetail;
          keyDetail = stringKeyDetail.rebuild((b) => b.ttl=event.ttl);
        } else if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b.ttl=event.ttl);
        } else if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) => b.ttl=event.ttl);
        } else if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) => b.ttl=event.ttl);
        } else if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail zsetKeyDetail = keyDetail;
          keyDetail = zsetKeyDetail.rebuild((b) => b.ttl=event.ttl);
        }
        b.keyDetail = keyDetail;
      });
    } else if(event is KeyDelete) {
      yield state.rebuild((b) {
        if(StringUtil.isEqual(state.selectedKey, event.key)) {
          b.selectedKey = "";
        }
        b.scanKeyList.remove(event.key);
        b.keyDetail=null;
      });
    } else if(event is DatabasePanelKeyRenameEvent) {
      yield state.rebuild((b) {
        if(StringUtil.isEqual(b.selectedKey, event.keyName)) {
          b.selectedKey = event.newKeyName;
        }
        var keyDetail = b.keyDetail;
        if(keyDetail is StringKeyDetail) {
          StringKeyDetail stringKeyDetail = keyDetail;
          keyDetail = stringKeyDetail.rebuild((b) => b.key=event.newKeyName);
        } else if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b.key=event.newKeyName);
        } else if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) => b.key=event.newKeyName);
        } else if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) => b.key=event.newKeyName);
        } else if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail zsetKeyDetail = keyDetail;
          keyDetail = zsetKeyDetail.rebuild((b) => b.key=event.newKeyName);
        }
        b.keyDetail = keyDetail;
        b.scanKeyList.remove(event.keyName);
        b.scanKeyList.insert(0, event.newKeyName);

      });
    }
  }

}

abstract class DatabasePanelEvent {}

class KeyDetailChanged extends DatabasePanelEvent {
  BaseKeyDetail keyDetail;
  KeyDetailChanged(this.keyDetail);
}

class SelectedKeyChanged extends DatabasePanelEvent {
  String selectedKey;
  SelectedKeyChanged(this.selectedKey);
}

class KeyTTLChanged extends DatabasePanelEvent {
  int ttl;
  KeyTTLChanged(this.ttl);
}

class KeyDelete extends DatabasePanelEvent {
  String key;
  KeyDelete(this.key);
}

class ScanKeyListChanged extends DatabasePanelEvent {
  List<String> scanKeyList;
  ScanKeyListChanged(this.scanKeyList);
}

class ScanKeyListClear extends DatabasePanelEvent {}

class DatabasePanelKeyRenameEvent extends DatabasePanelEvent {
  String keyName;
  String newKeyName;
  DatabasePanelKeyRenameEvent(this.keyName, this.newKeyName);
}