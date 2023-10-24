import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'view_event_event.dart';
part 'view_event_state.dart';

class ViewEventBloc extends Bloc<ViewEventEvent, ViewEventState> {
  ViewEventBloc() : super(ViewEventInitial()) {}
}
