
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';

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
          MapBuilder<String, int> dbKeyNumMap = BuiltMap<String, int>().toBuilder();
          for(int i = 0; i < event.dbNum; i++) {
            dbKeyNumMap["db$i"] = -1;
          }
          b.dbKeyNumMap=dbKeyNumMap;
        });
        b.connectedRedisMap = connectedRedisMap;
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