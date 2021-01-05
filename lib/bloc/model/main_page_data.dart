
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

  @nullable
  BaseKeyDetail get keyDetail;

  PanelInfo._();
  factory PanelInfo([updates(PanelInfoBuilder b)]) = _$PanelInfo;

}

abstract class BaseKeyDetail {

  @nullable
  String get key;

  @nullable
  String get type;

  @nullable
  int get ttl;

}

abstract class StringKeyDetail implements BaseKeyDetail, Built<StringKeyDetail, StringKeyDetailBuilder>  {

  @nullable
  String get value;

  StringKeyDetail._();
  factory StringKeyDetail([updates(StringKeyDetailBuilder b)]) = _$StringKeyDetail;

}

abstract class HashKeyDetail implements BaseKeyDetail, Built<HashKeyDetail, HashKeyDetailBuilder>  {


  HashKeyDetail._();
  factory HashKeyDetail([updates(HashKeyDetailBuilder b)]) = _$HashKeyDetail;

}

abstract class ListKeyDetail implements BaseKeyDetail, Built<ListKeyDetail, ListKeyDetailBuilder>  {


  ListKeyDetail._();
  factory ListKeyDetail([updates(ListKeyDetailBuilder b)]) = _$ListKeyDetail;

}

abstract class SetKeyDetail implements BaseKeyDetail, Built<SetKeyDetail, SetKeyDetailBuilder>  {


  SetKeyDetail._();
  factory SetKeyDetail([updates(SetKeyDetailBuilder b)]) = _$SetKeyDetail;

}

abstract class ZSetKeyDetail implements BaseKeyDetail, Built<ZSetKeyDetail, ZSetKeyDetailBuilder>  {


  ZSetKeyDetail._();
  factory ZSetKeyDetail([updates(ZSetKeyDetailBuilder b)]) = _$ZSetKeyDetail;

}