import 'package:flutter/material.dart';

import 'package:id_generator/features/admin/createEvent/bloc/create_event_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final CreateEventBloc createEventBloc = CreateEventBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventBloc, CreateEventState>(
      bloc: createEventBloc,
      listenWhen: (previous, current) => current is CreateEventActionState,
      buildWhen: (previous, current) => current is! CreateEventActionState,
      listener: (context, state) {
        if (state is SelectEventStartDateActionState) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        createEventBloc.add(
                          SelectStartDateButtonClickedEvent(),
                        );
                      },
                      child: const Text("SelectStartDate"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createEventBloc.add(
                          SelectEndDateButtonClickedEvent(),
                        );
                      },
                      child: const Text("SelectEndDate"),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        createEventBloc.add(
                          SelectStartTimeButtonClickedEvent(),
                        );
                      },
                      child: const Text("SelectStartTime"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        createEventBloc.add(
                          SelectEndTimeButtonClickedEvent(),
                        );
                      },
                      child: const Text("SelectEndTime"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
