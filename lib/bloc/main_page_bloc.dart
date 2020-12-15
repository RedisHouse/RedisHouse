
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';

class MainPageBloc extends BaseBloc<MainPageEvent, MainPageData> {

  MainPageBloc(BuildContext context, MainPageData initialState)
      : super(context, initialState);

  @override
  Stream<MainPageData> mapEventToState(event) async* {
    if(event is ConnectionListOpenEvent) {
      yield state.rebuild((b) => b..connectionListOpen=event.open);
    }
  }

}

abstract class MainPageEvent {}

class ConnectionListOpenEvent extends MainPageEvent {
  bool open;
  ConnectionListOpenEvent(this.open);
}