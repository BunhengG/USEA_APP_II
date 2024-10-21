import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../api/fetch_attendance.dart';
import '../../../model/attendance_model.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceLoading()) {
    // Register the event handler for FetchAttendance event
    on<FetchAttendance>(_onFetchAttendance);
  }

  // Event handler for FetchAttendance
  Future<void> _onFetchAttendance(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());

    try {
      // Fetch attendance data
      List<Attendances> attendances = await fetchAttendanceData(
        event.studentId,
        event.password,
      );
      emit(AttendanceLoaded(attendances));
    } catch (e) {
      emit(AttendanceError('Failed to fetch attendance data: $e'));
    }
  }
}
