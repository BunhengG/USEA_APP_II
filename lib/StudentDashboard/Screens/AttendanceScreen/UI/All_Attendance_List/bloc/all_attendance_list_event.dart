import 'package:equatable/equatable.dart';
import '../../../model/attendance_model.dart';

abstract class AttendanceListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAttendanceList extends AttendanceListEvent {
  final List<Attendances> attendances;

  FetchAttendanceList(this.attendances);

  @override
  List<Object?> get props => [attendances];
}
