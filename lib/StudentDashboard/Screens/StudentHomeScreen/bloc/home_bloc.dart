// home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/fetch_credit.dart';
import '../../../auth/model/login_model_class.dart';
import '../model/credit_model.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../../helpers/shared_pref_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        // Load user data from SharedPreferences
        UserData? userData = await _loadUserData();

        // Load credit data from API
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();
        CreditData? creditData;

        if (studentId != null && password != null) {
          creditData = await fetchCreditData(studentId, password);
        }

        if (userData != null && creditData != null) {
          emit(HomeLoaded(userData: userData, creditData: creditData));
        } else {
          emit(const HomeError('Error loading data.'));
        }
      } catch (e) {
        emit(HomeError('Failed to load home data: $e'));
      }
    });
  }

  Future<UserData?> _loadUserData() async {
    // Update this to call the correct method in SharedPrefHelper
    UserData? userData = await SharedPrefHelper.getStoredUserData();
    return userData;
  }
}
