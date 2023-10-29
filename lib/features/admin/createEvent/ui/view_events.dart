import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:id_generator/features/admin/createEvent/bloc/view_event_bloc.dart';
import '../bloc/create_event_bloc.dart';

class ViewEvents extends StatefulWidget {
  const ViewEvents({super.key});

  @override
  State<ViewEvents> createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
  final ViewEventBloc viewEventBloc = ViewEventBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewEventBloc, ViewEventState>(
      bloc: viewEventBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_calendar_outlined),
                label: const Text("Edit "),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete),
                label: const Text("Edit "),
              ),
            ],
          )),
        );
      },
    );
  }
}
