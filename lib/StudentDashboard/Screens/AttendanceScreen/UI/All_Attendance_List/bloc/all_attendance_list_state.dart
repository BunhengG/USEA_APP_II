import 'package:equatable/equatable.dart';
import '../../../model/attendance_model.dart';

abstract class AttendanceListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceListInitial extends AttendanceListState {}

class AttendanceListLoading extends AttendanceListState {}

class AttendanceListLoaded extends AttendanceListState {
  final List<Attendances> attendances;

  AttendanceListLoaded(this.attendances);

  @override
  List<Object?> get props => [attendances];
}

class AttendanceListError extends AttendanceListState {
  final String message;

  AttendanceListError(this.message);

  @override
  List<Object?> get props => [message];
}
