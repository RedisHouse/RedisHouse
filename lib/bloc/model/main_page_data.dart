
import 'package:built_value/built_value.dart';

part 'main_page_data.g.dart';

abstract class MainPageData implements Built<MainPageData, MainPageDataBuilder>  {

  @nullable
  bool get connectionListOpen;

  MainPageData._();
  factory MainPageData([updates(MainPageDataBuilder b)]) = _$MainPageData;

}