// schedule_event.dart
import 'package:equatable/equatable.dart';

// this ScheduleEvent is a base class for all schedule events.
abstract class ScheduleEvent extends Equatable {
  // Constructor for the base class
  const ScheduleEvent();

  // Override the props getter to define which properties should be used for comparison.
  @override
  List<Object> get props =>
      []; // An empty list indicates no properties for this base class.
}

//NOTE: when day selected this event will be fired
class LoadSchedule extends ScheduleEvent {
  final String studentId;
  final String password;
  final String date;

  // Constructor for the LoadSchedule event, accepting studentId, password, and date as parameters.
  const LoadSchedule(this.studentId, this.password, this.date);

  @override
  List<Object> get props => [studentId, password]; // This ensures that different events with the same ID and password are considered equal.
}
