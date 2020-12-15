
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'main_page_data.g.dart';

abstract class MainPageData implements Built<MainPageData, MainPageDataBuilder>  {

  @nullable
  bool get connectionListOpen;

  @nullable
  BuiltMap<String, ConnectionDetail> get connectedRedisMap;

  MainPageData._();
  factory MainPageData([updates(MainPageDataBuilder b)]) = _$MainPageData;

}

abstract class ConnectionDetail implements Built<ConnectionDetail, ConnectionDetailBuilder>  {

  @nullable
  int get dbNum;

  @nullable
  BuiltMap<String, int> get dbKeyNumMap;

  ConnectionDetail._();
  factory ConnectionDetail([updates(ConnectionDetailBuilder b)]) = _$ConnectionDetail;
}