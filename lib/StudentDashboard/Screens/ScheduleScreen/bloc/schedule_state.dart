// schedule_state.dart

import 'package:equatable/equatable.dart';
import '../model/schedule_model_class.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

// This state represents the initial state of the schedule before any data is loaded.
class ScheduleInitial extends ScheduleState {}

// This state represents the loading state when the schedule data is being fetched.
class ScheduleLoading extends ScheduleState {}

// This state represents the successful loading of schedule data.
class ScheduleLoaded extends ScheduleState {
  // A list of ScheduleItem objects representing the loaded schedule.
  final List<ScheduleItem> schedule;

  // Constructor for the ScheduleLoaded state, accepting the schedule as a parameter.
  const ScheduleLoaded(this.schedule);

  @override
  List<Object> get props => [schedule];
}

// This state represents an error that occurred during the loading of the schedule data.
class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}
