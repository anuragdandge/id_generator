import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(CreateEventInitial()) {
    on<SelectStartDateButtonClickedEvent>(selectStartDateButtonClickedEvent);
    on<SelectEndDateButtonClickedEvent>(selectEndDateButtonClickedEvent);
    on<SelectStartTimeButtonClickedEvent>(selectStartTimeButtonClickedEvent);
    on<SelectEndTimeButtonClickedEvent>(selectEndTimeButtonClickedEvent);
  }

  FutureOr<void> selectStartDateButtonClickedEvent(
      SelectStartDateButtonClickedEvent event, Emitter<CreateEventState> emit) {
    debugPrint("Select Start Date Button Clicked ! ");
    emit(SelectEventStartDateActionState());
  }

  FutureOr<void> selectEndDateButtonClickedEvent(
      SelectEndDateButtonClickedEvent event, Emitter<CreateEventState> emit) {
    emit(SelectEventEndDateActionState());
    debugPrint("Select End Date Button Clicked ! ");
  }

  FutureOr<void> selectStartTimeButtonClickedEvent(
      SelectStartTimeButtonClickedEvent event, Emitter<CreateEventState> emit) {
    debugPrint("Select Start Time Button Clicked ! ");
    emit(SelectEventStartTimeActionState());
  }

  FutureOr<void> selectEndTimeButtonClickedEvent(
      SelectEndTimeButtonClickedEvent event, Emitter<CreateEventState> emit) {
    debugPrint("Select End Button Clicked ! ");
    emit(SelectEventEndTimeActionState());
  }
}
