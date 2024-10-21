// schedule_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/schedule_model_class.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';
import '../../../api/fetch_schedule.dart';

// Define the ScheduleBloc class that extends Bloc.
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository repository;

  // Constructor for the ScheduleBloc, initializing with a repository and setting the initial state.
  ScheduleBloc(this.repository) : super(ScheduleInitial()) {
    // Listen for LoadSchedule events.
    on<LoadSchedule>((event, emit) async {
      emit(ScheduleLoading()); // Emit loading state

      try {
        // Fetch schedule data using the repository with the added date
        final List<ScheduleItem> schedule = await repository.fetchScheduleData(
          event.studentId,
          event.password,
          event.date, // Pass date to the repository
        );

        // Check if the schedule list is not empty
        if (schedule.isNotEmpty) {
          emit(ScheduleLoaded(
              schedule)); // Emit loaded state with retrieved data
        } else {
          emit(const ScheduleError(
              'No schedule data found')); // Emit error state if no data
        }
      } catch (e) {
        emit(ScheduleError(
            e.toString())); // Emit error state with the exception message
      }
    });
  }
}
