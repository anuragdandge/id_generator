part of 'create_event_bloc.dart';

@immutable
abstract class CreateEventState {}

abstract class CreateEventActionState extends CreateEventState {}

class CreateEventInitial extends CreateEventState {}

class SelectEventStartDateActionState extends CreateEventActionState {}

class SelectEventEndDateActionState extends CreateEventActionState {}

class SelectEventStartTimeActionState extends CreateEventActionState {}

class SelectEventEndTimeActionState extends CreateEventActionState {}
