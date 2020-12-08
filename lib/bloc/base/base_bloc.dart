import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BuildContext context;
  BaseBloc(BuildContext context, State initialState) : context = context, super(initialState);
}