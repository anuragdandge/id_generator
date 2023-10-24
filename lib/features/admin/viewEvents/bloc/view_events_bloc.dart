import 'package:bloc/bloc.dart';
import 'package:id_generator/features/admin/createEvent/models/event_model.dart';
import 'package:id_generator/features/admin/createEvent/ui/create_event.dart';
import 'package:meta/meta.dart';

part 'view_events_event.dart';
part 'view_events_state.dart';

class ViewEventsBloc extends Bloc<ViewEventsEvent, ViewEventsState> {
  ViewEventsBloc() : super(ViewEventsInitial()) {
    on<ViewEventsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
