// Bloc
import 'package:bloc/bloc.dart';

import '../../../api/fetch_performance.dart';
import '../../../helpers/shared_pref_helper.dart';
import 'performance_event.dart';
import 'performance_state.dart';

// Bloc
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  PerformanceBloc() : super(PerformanceInitial()) {
    // Registering the event handler
    on<FetchPerformanceData>((event, emit) async {
      emit(PerformanceLoading());

      try {
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();

        if (studentId != null && password != null) {
          final data = await fetchPerformanceData(studentId, password);
          emit(PerformanceLoaded(data));
        } else {
          emit(PerformanceError('StudentID or Password is not available'));
        }
      } catch (e) {
        emit(PerformanceError(e.toString()));
      }
    });
  }
}
