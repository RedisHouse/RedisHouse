
import 'dart:ffi';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';

part 'main_page_data.g.dart';

abstract class MainPageData implements Built<MainPageData, MainPageDataBuilder>  {

  @nullable
  bool get redisListOpen;

  @nullable
  bool get logOpen;

  @nullable
  BuiltMap<String, ConnectionDetail> get connectedRedisMap;

  @nullable
  BuiltList<PanelInfo> get panelList;

  @nullable
  int get activePanelIndex;

  MainPageData._();
  factory MainPageData([updates(MainPageDataBuilder b)]) = _$MainPageData;

}

abstract class ConnectionDetail implements Built<ConnectionDetail, ConnectionDetailBuilder>  {

  @nullable
  bool get expanded;

  @nullable
  int get dbNum;

  @nullable
  BuiltMap<String, int> get dbKeyNumMap;

  ConnectionDetail._();
  factory ConnectionDetail([updates(ConnectionDetailBuilder b)]) = _$ConnectionDetail;

}

abstract class PanelInfo implements Built<PanelInfo, PanelInfoBuilder>  {

  @nullable
  String get uuid;

  @nullable
  String get type;

  @nullable
  String get name;

  @nullable
  NewConnectionData get connection;

  @nullable
  String get dbIndex;

  PanelInfo._();
  factory PanelInfo([updates(PanelInfoBuilder b)]) = _$PanelInfo;

}
