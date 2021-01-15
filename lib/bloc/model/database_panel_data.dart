import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';

part 'database_panel_data.g.dart';

abstract class DatabasePanelData implements Built<DatabasePanelData, DatabasePanelDataBuilder>  {

  @nullable
  String get panelUUID;

  @nullable
  NewConnectionData get connection;

  @nullable
  String get dbIndex;

  @nullable
  int get dbSize;

  @nullable
  BaseKeyDetail get keyDetail;

  @nullable
  String get selectedKey;

  @nullable
  BuiltList<String> get scanKeyList;

  @nullable
  int get navScanIndex;

  @nullable
  BuiltList<int> get navScanIndexList;

  DatabasePanelData._();
  factory DatabasePanelData([updates(DatabasePanelDataBuilder b)]) = _$DatabasePanelData;

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

  @nullable
  String get valueChanged;

  StringKeyDetail._();
  factory StringKeyDetail([updates(StringKeyDetailBuilder b)]) = _$StringKeyDetail;

}

abstract class HashKeyDetail implements BaseKeyDetail, Built<HashKeyDetail, HashKeyDetailBuilder>  {

  @nullable
  int get hlen;

  @nullable
  int get scanIndex;

  @nullable
  BuiltMap<String, String> get scanKeyValueMap;

  @nullable
  String get selectedKey;

  @nullable
  String get selectedKeyChanged;

  @nullable
  String get selectedValue;

  @nullable
  String get selectedValueChanged;

  HashKeyDetail._();
  factory HashKeyDetail([updates(HashKeyDetailBuilder b)]) = _$HashKeyDetail;

}

abstract class ListKeyDetail implements BaseKeyDetail, Built<ListKeyDetail, ListKeyDetailBuilder>  {

  @nullable
  int get llen;

  @nullable
  int get pageIndex;

  @nullable
  BuiltList<String> get rangeList;

  @nullable
  int get selectedIndex;

  @nullable
  String get selectedValue;

  @nullable
  String get selectedValueChanged;

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