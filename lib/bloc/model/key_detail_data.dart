
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:redis_house/bloc/model/new_connection_data.dart';
import 'package:redis_house/model/serializers.dart';

part 'key_detail_data.g.dart';

abstract class KeyDetailData implements Built<KeyDetailData, KeyDetailDataBuilder>  {

  @nullable
  String get panelUUID;

  @nullable
  NewConnectionData get connection;

  @nullable
  BaseKeyDetail get keyDetail;

  KeyDetailData._();
  factory KeyDetailData([updates(KeyDetailDataBuilder b)]) = _$KeyDetailData;

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