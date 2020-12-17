
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/util/string_util.dart';
import 'package:uuid/uuid.dart';

class MainPageBloc extends BaseBloc<MainPageEvent, MainPageData> {

  MainPageBloc(BuildContext context, MainPageData initialState)
      : super(context, initialState);

  @override
  Stream<MainPageData> mapEventToState(event) async* {
    if(event is RedisListOpenEvent) {
      yield state.rebuild((b) => b..redisListOpen=event.open);
    } else if(event is LogOpenEvent) {
      yield state.rebuild((b) => b..logOpen=event.open);
    } else if(event is ConnectionOpenEvent) {
      yield state.rebuild((b) {
        MapBuilder<String, ConnectionDetail> connectedRedisMap = b.connectedRedisMap;
        if(connectedRedisMap == null) {
          connectedRedisMap = BuiltMap().toBuilder();
        }
        connectedRedisMap[event.connectionId] = ConnectionDetail((b) {
          b.dbNum=event.dbNum;
          b.expanded=true;
          MapBuilder<String, int> dbKeyNumMap = BuiltMap<String, int>().toBuilder();
          for(int i = 0; i < event.dbNum; i++) {
            dbKeyNumMap["db$i"] = -1;
          }
          b.dbKeyNumMap=dbKeyNumMap;
        });
        b.connectedRedisMap = connectedRedisMap;
      });
    } else if(event is ConnectionCloseEvent) {
      yield state.rebuild((b) {
        b.connectedRedisMap.remove(event.connectionId);
      });
    } else if(event is ConnectionExpandEvent) {
      yield state.rebuild((b) {
        var detail = b.connectedRedisMap[event.connectionId];
        b.connectedRedisMap[event.connectionId] = detail.rebuild((b) => b.expanded=event.expanded);
      });
    } else if(event is PanelOpenEvent) {
      yield state.rebuild((b) {
        var panelListBuilder = b.panelList;
        if(panelListBuilder == null) {
          panelListBuilder = BuiltList<PanelInfo>().toBuilder();
        }
        panelListBuilder.add(PanelInfo((b) => b
            ..uuid=Uuid().v1()
            ..type=event.type
            ..name=event.connection.redisName
            ..connection=event.connection.toBuilder()
            ..dbIndex=event.dbIndex
        ));
        b.panelList = panelListBuilder;
      });
    } else if(event is PanelCloseEvent) {
      yield state.rebuild((b) {
        var panelListBuilder = b.panelList;
        panelListBuilder.removeWhere((item) => StringUtil.isEqual(item.uuid, event.uuid));
        b.panelList = panelListBuilder;
      });
    }
  }

}

abstract class MainPageEvent {}

class RedisListOpenEvent extends MainPageEvent {
  bool open;
  RedisListOpenEvent(this.open);
}

class LogOpenEvent extends MainPageEvent {
  bool open;
  LogOpenEvent(this.open);
}

class ConnectionOpenEvent extends MainPageEvent {
  String connectionId;
  int dbNum;
  ConnectionOpenEvent(this.connectionId, this.dbNum);
}

class ConnectionCloseEvent extends MainPageEvent {
  String connectionId;
  ConnectionCloseEvent(this.connectionId,);
}

class ConnectionExpandEvent extends MainPageEvent {
  String connectionId;
  bool expanded;
  ConnectionExpandEvent(this.connectionId, this.expanded);
}

class PanelOpenEvent extends MainPageEvent {
  String type;
  NewConnectionData connection;
  String dbIndex;
  PanelOpenEvent(this.type, this.connection, this.dbIndex);
}

class PanelCloseEvent extends MainPageEvent {
  String uuid;
  PanelCloseEvent(this.uuid,);
}