import 'package:flutter/material.dart';
import 'package:redis_house/bloc/main_page_bloc.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/log/log.dart';
import 'package:built_collection/built_collection.dart';
import 'package:redis_house/util/data_structure.dart';
import 'package:redis_house/util/string_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabasePanelBloc extends BaseBloc<DatabasePanelEvent, DatabasePanelData> {

  DatabasePanelBloc(BuildContext context, DatabasePanelData initialState) : super(context, initialState);

  @override
  Stream<DatabasePanelData> mapEventToState(event) async* {
    if(event is DBORDBSizeChanged) {
      yield state.rebuild((b) {
        if(StringUtil.isNotBlank(event.dbIndex)) {
          b.dbIndex = event.dbIndex;
        }
        if(event.dbSize != null) {
          b.dbSize = event.dbSize;
          // 通知 MainPage 更新某个 DB 的 DBSize
          context.read<MainPageBloc>().add(ConnectionDBSizeUpdateEvent(state.connection.id, state.dbIndex, event.dbSize));
        }
      });
    } else if(event is KeyScanNavIndexListClear) {
      yield state.rebuild((b) => b
        ..navScanIndex=0
        ..navScanIndexList=ListBuilder([0])
      );
    } else if(event is KeyScanNavIndexListAdd) {
      yield state.rebuild((b) => b
          ..navScanIndexList.add(event.index)
      );
    } else if(event is KeyScanNavIndexChanged) {
      yield state.rebuild((b) => b
        ..navScanIndex=event.index
      );
    } else if(event is SelectedKey) {
      yield state.rebuild((b) => b.selectedKey=event.selectedKey);
    } else if(event is ScanKeyListChanged) {
      yield state.rebuild((b) => b.scanKeyList=event.scanKeyList.toBuiltList().toBuilder());
    } else if(event is ScanKeyListClear) {
      yield state.rebuild((b) => b..selectedKey=""..scanKeyList.clear()..keyDetail=null);
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
    } else if(event is KeyRenameEvent) {
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
    } else if(event is KeyDelete) {
      yield state.rebuild((b) {
        if(StringUtil.isEqual(state.selectedKey, event.key)) {
          b.selectedKey = "";
        }
        b.dbSize=b.dbSize-1;
        b.scanKeyList.remove(event.key);
        b.keyDetail=null;
      });
      // 通知 MainPage 更新某个 DB 的 DBSize
      context.read<MainPageBloc>().add(ConnectionDBSizeUpdateEvent(state.connection.id, state.dbIndex, state.dbSize));
    } else if(event is StringValueChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is StringKeyDetail) {
          StringKeyDetail stringKeyDetail = keyDetail;
          keyDetail = stringKeyDetail.rebuild((b) => b.valueChanged=event.value);
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is StringNewValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is StringKeyDetail) {
          StringKeyDetail stringKeyDetail = keyDetail;
          keyDetail = stringKeyDetail.rebuild((b) => b.value=event.newValue);
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashRefresh) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
            ..hlen=event.hlen
            ..scanIndex=event.scanIndex
            ..scanKeyValueMap=BuiltMap<String, String>.from(event.scanKeyValueMap).toBuilder()
            ..selectedKey=""
            ..selectedKeyChanged=""
            ..selectedValue=""
            ..selectedValueChanged=""
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashScanChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
            ..scanKeyValueMap=BuiltMap<String, String>.from(event.scanKeyValueMap).toBuilder()
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashNewKeyValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
            ..scanKeyValueMap.putIfAbsent(event.key, () => event.value)
            ..selectedKey=event.key
            ..selectedKeyChanged=""
            ..selectedValue=event.value
            ..selectedValueChanged=""
            ..hlen=b.hlen+1
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashSelectedKeyValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
              ..selectedKey=event.selectedKey
              ..selectedValue=event.selectedValue
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashSelectedKeyChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b.selectedKeyChanged=event.key);
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashSelectedKeyDeleted) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
              ..selectedKey=""
              ..selectedKeyChanged=""
              ..selectedValue=""
              ..selectedValueChanged=""
              ..hlen=b.hlen-1
              ..scanKeyValueMap.remove(event.key)
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashNewSelectedKey) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
              ..selectedKey=event.newKey
              ..scanKeyValueMap.remove(hashKeyDetail.selectedKey)
              ..scanKeyValueMap.putIfAbsent(event.newKey, () => hashKeyDetail.selectedValue)
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashSelectedValueChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) => b
              ..selectedValueChanged=event.value
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is HashNewSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is HashKeyDetail) {
          HashKeyDetail hashKeyDetail = keyDetail;
          keyDetail = hashKeyDetail.rebuild((b) {
            b.selectedValue=event.newValue;
            b.scanKeyValueMap.updateValue(b.selectedKey, (s) => event.newValue);
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListRefresh) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.llen=event.llen;
            b.pageIndex=event.pageIndex;
            b.rangeList=event.valueList.toBuiltList().toBuilder();
            b.selectedIndex=-1;
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListPageUpdate) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if (keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.pageIndex = event.pageIndex;
            b.rangeList = event.valueList.toBuiltList().toBuilder();
            b.selectedIndex = -1;
            b.selectedValue = "";
            b.selectedValueChanged = "";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.selectedIndex=event.selectedIndex;
            b.selectedValue=event.value;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListSelectedValueChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.selectedValueChanged=event.value;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListSelectedValueDeleted) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.llen=b.llen-1;
            b.selectedIndex=-1;
            b.selectedValue="";
            b.rangeList.remove(event.value);
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListNewSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            b.selectedValue=event.value;
            b.rangeList.removeAt(b.selectedIndex);
            b.rangeList.insert(b.selectedIndex, event.value);
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ListNewValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ListKeyDetail) {
          ListKeyDetail listKeyDetail = keyDetail;
          keyDetail = listKeyDetail.rebuild((b) {
            if(b.pageIndex == 1) {
              b.rangeList.insert(0, event.value);
              b.rangeList.removeLast();
              b.selectedIndex=0;
              b.selectedValue=event.value;
              b.selectedValueChanged="";
            }
            b.llen=b.llen+1;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetRefresh) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.slen=event.slen;
            b.scanIndex=event.scanIndex;
            b.scanList=event.scanList.toBuiltList().toBuilder();
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetScanChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.scanIndex=event.scanIndex;
            b.scanList=event.scanList.toBuiltList().toBuilder();
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.selectedValue=event.value;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetSelectedValueChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.selectedValueChanged=event.value;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetNewSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.scanList.remove(b.selectedValue);
            b.scanList.add(event.value);
            b.selectedValue=event.value;
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetSelectedValueDeleted) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.scanList.remove(event.value);
            b.slen=b.slen-1;
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is SetNewValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is SetKeyDetail) {
          SetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.scanList.add(event.value);
            b.slen=b.slen+1;
            b.selectedValue=event.value;
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetRefresh) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.zlen=event.zlen;
            b.pageIndex=event.pageIndex;
            b.valueList=event.valueList.toBuiltList().toBuilder();
            b.selectedScore="";
            b.selectedScoreChanged="";
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.selectedScore=event.score;
            b.selectedValue=event.value;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetSelectedScoreChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) => b
            ..selectedScoreChanged = event.score
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetNewSelectedScore) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            int index = b.valueList.build().indexWhere((e) => StringUtil.isEqual(e.last, b.selectedValue));
            Pair<String, String> item = b.valueList[index];
            item.first = event.score;
            b.valueList.removeAt(index);
            b.valueList.insert(index, item);
            b.selectedScore=event.score;
            b.selectedScoreChanged;
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetSelectedValueChanged) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) => b
            ..selectedValueChanged = event.value
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetNewSelectedValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            int index = b.valueList.build().indexWhere((e) => StringUtil.isEqual(e.last, b.selectedValue));
            Pair<String, String> item = b.valueList[index];
            item.last = event.value;
            b.valueList.removeAt(index);
            b.valueList.insert(index, item);
            b.selectedValue = event.value;
            b.selectedValueChanged = "";
          });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetSelectedValueDeleted) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) => b
            ..valueList.removeWhere((e) => StringUtil.isEqual(e.last, event.value))
            ..selectedScore=""
            ..selectedScoreChanged=""
            ..selectedValue=""
            ..selectedValueChanged = ""
            ..zlen=b.zlen-1
          );
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetNewValue) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.selectedScore="";
            b.selectedScoreChanged="";
            b.selectedValue="";
            b.selectedValueChanged = "";
            b.zlen=b.zlen+1;
            });
          b.keyDetail = keyDetail;
        }
      });
    } else if(event is ZSetPageUpdate) {
      yield state.rebuild((b) {
        var keyDetail = b.keyDetail;
        if(keyDetail is ZSetKeyDetail) {
          ZSetKeyDetail setKeyDetail = keyDetail;
          keyDetail = setKeyDetail.rebuild((b) {
            b.pageIndex=event.pageIndex;
            b.valueList=event.valueList.toBuiltList().toBuilder();
            b.selectedScore="";
            b.selectedScoreChanged="";
            b.selectedValue="";
            b.selectedValueChanged="";
          });
          b.keyDetail = keyDetail;
        }
      });
    }
  }

}

abstract class DatabasePanelEvent {}

class DBORDBSizeChanged extends DatabasePanelEvent {
  String dbIndex;
  int dbSize;
  DBORDBSizeChanged({this.dbIndex, this.dbSize});
}

class KeyScanNavIndexListClear extends DatabasePanelEvent {
  KeyScanNavIndexListClear();
}

class KeyScanNavIndexListAdd extends DatabasePanelEvent {
  int index;
  KeyScanNavIndexListAdd(this.index);
}

class KeyScanNavIndexChanged extends DatabasePanelEvent {
  int index;
  KeyScanNavIndexChanged(this.index);
}

class KeyDetailChanged extends DatabasePanelEvent {
  BaseKeyDetail keyDetail;
  KeyDetailChanged(this.keyDetail);
}

class SelectedKey extends DatabasePanelEvent {
  String selectedKey;
  SelectedKey(this.selectedKey);
}

class KeyRenameEvent extends DatabasePanelEvent {
  String keyName;
  String newKeyName;
  KeyRenameEvent(this.keyName, this.newKeyName);
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

class StringValueChanged extends DatabasePanelEvent {
  String value;
  StringValueChanged(this.value);
}

class StringNewValue extends DatabasePanelEvent {
  String newValue;
  StringNewValue(this.newValue);
}

class HashRefresh extends DatabasePanelEvent {
  int hlen;
  int scanIndex;
  Map<String, String> scanKeyValueMap;
  HashRefresh(this.hlen, this.scanIndex, this.scanKeyValueMap);
}

class HashScanChanged extends DatabasePanelEvent {
  Map<String, String> scanKeyValueMap;
  HashScanChanged(this.scanKeyValueMap);
}

class HashNewKeyValue extends DatabasePanelEvent {
  String key;
  String value;
  HashNewKeyValue(this.key, this.value);
}

class HashSelectedKeyValue extends DatabasePanelEvent {
  String selectedKey;
  String selectedValue;
  HashSelectedKeyValue(this.selectedKey, this.selectedValue);
}

class HashSelectedKeyChanged extends DatabasePanelEvent {
  String key;
  HashSelectedKeyChanged(this.key);
}

class HashSelectedKeyDeleted extends DatabasePanelEvent {
  String key;
  HashSelectedKeyDeleted(this.key);
}

class HashNewSelectedKey extends DatabasePanelEvent {
  String newKey;
  HashNewSelectedKey(this.newKey);
}

class HashSelectedValueChanged extends DatabasePanelEvent {
  String value;
  HashSelectedValueChanged(this.value);
}

class HashNewSelectedValue extends DatabasePanelEvent {
  String newValue;
  HashNewSelectedValue(this.newValue);
}

class ListRefresh extends DatabasePanelEvent {
  int llen;
  int pageIndex;
  List<String> valueList;
  ListRefresh(this.llen, this.pageIndex, this.valueList);
}

class ListSelectedValue extends DatabasePanelEvent {
  int selectedIndex;
  String value;
  ListSelectedValue(this.selectedIndex, this.value);
}

class ListSelectedValueChanged extends DatabasePanelEvent {
  String value;
  ListSelectedValueChanged(this.value);
}

class ListSelectedValueDeleted extends DatabasePanelEvent {
  String value;
  ListSelectedValueDeleted(this.value);
}

class ListNewSelectedValue extends DatabasePanelEvent {
  String value;
  ListNewSelectedValue(this.value);
}

class ListNewValue extends DatabasePanelEvent {
  String value;
  ListNewValue(this.value);
}

class ListPageUpdate extends DatabasePanelEvent {
  int pageIndex;
  List<String> valueList;
  ListPageUpdate(this.pageIndex, this.valueList);
}

class SetRefresh extends DatabasePanelEvent {
  int slen;
  int scanIndex;
  List<String> scanList;
  SetRefresh(this.slen, this.scanIndex, this.scanList);
}

class SetScanChanged extends DatabasePanelEvent {
  int scanIndex;
  List<String> scanList;
  SetScanChanged(this.scanIndex, this.scanList);
}

class SetSelectedValue extends DatabasePanelEvent {
  String value;
  SetSelectedValue(this.value);
}

class SetSelectedValueChanged extends DatabasePanelEvent {
  String value;
  SetSelectedValueChanged(this.value);
}

class SetNewSelectedValue extends DatabasePanelEvent {
  String value;
  SetNewSelectedValue(this.value);
}

class SetSelectedValueDeleted extends DatabasePanelEvent {
  String value;
  SetSelectedValueDeleted(this.value);
}

class SetNewValue extends DatabasePanelEvent {
  String value;
  SetNewValue(this.value);
}

class ZSetRefresh extends DatabasePanelEvent {
  int zlen;
  int pageIndex;
  List<Pair<String, String>> valueList;
  ZSetRefresh(this.zlen, this.pageIndex, this.valueList);
}

class ZSetSelectedValue extends DatabasePanelEvent {
  String score;
  String value;
  ZSetSelectedValue(this.score, this.value);
}

class ZSetSelectedScoreChanged extends DatabasePanelEvent {
  String score;
  ZSetSelectedScoreChanged(this.score);
}

class ZSetNewSelectedScore extends DatabasePanelEvent {
  String score;
  ZSetNewSelectedScore(this.score);
}

class ZSetSelectedValueChanged extends DatabasePanelEvent {
  String value;
  ZSetSelectedValueChanged(this.value);
}

class ZSetNewSelectedValue extends DatabasePanelEvent {
  String value;
  ZSetNewSelectedValue(this.value);
}

class ZSetSelectedValueDeleted extends DatabasePanelEvent {
  String value;
  ZSetSelectedValueDeleted(this.value);
}

class ZSetNewValue extends DatabasePanelEvent {
  String score;
  String value;
  ZSetNewValue(this.score, this.value);
}

class ZSetPageUpdate extends DatabasePanelEvent {
  int pageIndex;
  List<Pair<String, String>> valueList;
  ZSetPageUpdate(this.pageIndex, this.valueList);
}