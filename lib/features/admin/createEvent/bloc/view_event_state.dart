part of 'view_event_bloc.dart';

@immutable
abstract class ViewEventState {}

abstract class ViewEventActionState extends ViewEventState {}

class ViewEventInitial extends ViewEventState {}

class EventLoadingState extends ViewEventState {}

class EventLoadedSuccessState extends ViewEventState {}

class EventErrorState extends ViewEventState {}

class EventEditedState extends ViewEventState {}

class EventDeletedState extends ViewEventState {}

class EventEditActionState extends ViewEventActionState {}

class EventDeleteActionState extends ViewEventActionState {}
