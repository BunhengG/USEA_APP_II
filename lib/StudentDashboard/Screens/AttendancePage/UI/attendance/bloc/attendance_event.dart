import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class FetchAttendance extends AttendanceEvent {
  final String studentId;
  final String password;

  const FetchAttendance(this.studentId, this.password);

  @override
  List<Object> get props => [studentId, password];
}
