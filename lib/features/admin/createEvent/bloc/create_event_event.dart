part of 'create_event_bloc.dart';

@immutable
abstract class CreateEventEvent {}

class SelectStartDateButtonClickedEvent extends CreateEventEvent {}

class SelectEndDateButtonClickedEvent extends CreateEventEvent {}

class SelectStartTimeButtonClickedEvent extends CreateEventEvent {}

class SelectEndTimeButtonClickedEvent extends CreateEventEvent {}

class CreateEventButtonClickedEvent extends CreateEventEvent {}
