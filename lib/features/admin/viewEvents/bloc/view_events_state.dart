part of 'view_events_bloc.dart';

@immutable
abstract class ViewEventsState {}

abstract class ViewEventsActionState {}

class ViewEventsInitial extends ViewEventsState {}

class ViewEventsLoadingState extends ViewEventsState {}

class ViewEventsLoadedSuccessState extends ViewEventsState {
  final List<CreateEventModel> events;
  ViewEventsLoadedSuccessState({required this.events});
}

class ViewEventsErrorState extends ViewEventsState {}
