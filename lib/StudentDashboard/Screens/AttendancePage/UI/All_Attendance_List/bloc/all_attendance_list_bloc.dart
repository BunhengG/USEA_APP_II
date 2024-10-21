import 'package:flutter_bloc/flutter_bloc.dart';
import 'all_attendance_list_event.dart';
import 'all_attendance_list_state.dart';

class AttendanceListBloc
    extends Bloc<AttendanceListEvent, AttendanceListState> {
  AttendanceListBloc() : super(AttendanceListInitial()) {
    on<FetchAttendanceList>((event, emit) async {
      emit(AttendanceListLoading());
      try {
        // Here you would normally fetch data, but for now, we will yield the list.
        emit(AttendanceListLoaded(event.attendances));
      } catch (e) {
        emit(AttendanceListError(e.toString()));
      }
    });
  }
}
