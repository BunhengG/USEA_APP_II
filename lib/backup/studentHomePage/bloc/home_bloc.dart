// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../api/fetch_credit.dart';
// import '../../../auth/model/login_model_class.dart';
// import '../model/credit_model.dart';
// import 'home_event.dart';
// import 'home_state.dart';
// import '../../../helpers/shared_pref_helper.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   HomeBloc() : super(HomeInitial()) {
//     // Load home data
//     on<LoadHomeData>((event, emit) async {
//       emit(HomeLoading());
//       try {
//         // Load user data from SharedPreferences
//         UserData? userData = await _loadUserData();

//         // Load credit data from API
//         String? studentId = await SharedPrefHelper.getStudentId();
//         String? password = await SharedPrefHelper.getPassword();
//         CreditData? creditData;

//         if (studentId != null && password != null) {
//           creditData = await fetchCreditData(studentId, password);
//         }

//         if (userData != null && creditData != null) {
//           emit(HomeLoaded(userData: userData, creditData: creditData));
//         } else {
//           emit(const HomeError('Error loading data.'));
//         }
//       } catch (e) {
//         emit(HomeError('Failed to load home data: $e'));
//       }
//     });

//     // Handle the connectivity check event
//     on<CheckConnectivity>((event, emit) async {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       _emitConnectivityState(connectivityResult, emit);

//       // Listen for future connectivity changes
//       _connectivitySubscription = Connectivity()
//           .onConnectivityChanged
//           .listen((ConnectivityResult result) {
//         _emitConnectivityState(result, emit);
//       });
//     });
//   }

//   void _emitConnectivityState(
//       ConnectivityResult result, Emitter<HomeState> emit) {
//     if (result == ConnectivityResult.none) {
//       emit(ConnectivityFailure());
//     } else {
//       emit(ConnectivitySuccess());
//       // Reload home data when connectivity is restored
//       add(LoadHomeData());
//     }
//   }

//   @override
//   Future<void> close() {
//     _connectivitySubscription.cancel();
//     return super.close();
//   }

//   Future<UserData?> _loadUserData() async {
//     // Fetch user data from SharedPreferences
//     return await SharedPrefHelper.getStoredUserData();
//   }
// }

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../StudentDashboard/api/fetch_credit.dart';
import '../../../StudentDashboard/auth/model/login_model_class.dart';
import '../../../StudentDashboard/Screens/StudentHomeScreen/model/credit_model.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../../StudentDashboard/helpers/shared_pref_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  HomeLoaded? _lastKnownState;

  HomeBloc() : super(HomeInitial()) {
    // Register the CheckConnectivity event handler
    on<CheckConnectivity>((event, emit) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      _emitConnectivityState(connectivityResult, emit);

      _connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        _emitConnectivityState(result, emit);
      });
    });

    // Load home data
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        UserData? userData = await _loadUserData();
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();
        CreditData? creditData;

        if (studentId != null && password != null) {
          creditData = await fetchCreditData(studentId, password);
        }

        if (userData != null && creditData != null) {
          _lastKnownState =
              HomeLoaded(userData: userData, creditData: creditData);
          emit(_lastKnownState!);
        } else {
          emit(const HomeError(
              'Error loading data: User or credit data is null.'));
        }
      } catch (e) {
        emit(HomeError('Failed to load home data: $e'));
      }
    });

    // Trigger the initial connectivity check
    add(CheckConnectivity());
  }

  void _emitConnectivityState(
      ConnectivityResult result, Emitter<HomeState> emit) {
    if (result == ConnectivityResult.none) {
      emit(ConnectivityFailure());
    } else {
      emit(ConnectivitySuccess());
      add(LoadHomeData()); // Trigger data load on connectivity restore
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  Future<UserData?> _loadUserData() async {
    return await SharedPrefHelper.getStoredUserData();
  }
}
