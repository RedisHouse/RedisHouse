import 'package:flutter/material.dart';
import 'package:redis_house/bloc/model/key_detail_data.dart';
import 'package:redis_house/bloc/base/base_bloc.dart';
import 'package:redis_house/log/log.dart';


class KeyDetailBloc extends BaseBloc<KeyDetailEvent, KeyDetailData> {

  KeyDetailBloc(BuildContext context, KeyDetailData initialState) : super(context, initialState);

  @override
  Stream<KeyDetailData> mapEventToState(event) async* {
    if(event is KeyRenameEvent) {
      var keyDetail = state.keyDetail;
      if(keyDetail is StringKeyDetail) {
        Log.d("KeyRenameEvent~~~~~~~~~~~~~~~~~~~~");
        yield state.rebuild((b) {
          b.keyDetail = keyDetail.rebuild((b) => b..key=event.newKeyName);
        });
      }
    }
  }

}

abstract class KeyDetailEvent {}

class KeyRenameEvent extends KeyDetailEvent {
  String keyName;
  String newKeyName;
  KeyRenameEvent(this.keyName, this.newKeyName);
}