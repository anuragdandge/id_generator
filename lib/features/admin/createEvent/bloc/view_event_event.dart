part of 'view_event_bloc.dart';

@immutable
abstract class ViewEventEvent {}

class EditEventButtonClickedEvent extends ViewEventEvent {}

class DeleteEventButtonClickedEvent extends ViewEventEvent {}
