// profile_bloc.dart
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/model/login_model_class.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Register the event handler
    on<LoadUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userDataJson = prefs.getString('user_data');

        if (userDataJson != null) {
          Map<String, dynamic> allUserDataMap = jsonDecode(userDataJson);
          UserData userData = UserData.fromJson(allUserDataMap);
          emit(ProfileLoaded(userData));
        } else {
          emit(ProfileError('No user data found in SharedPreferences'));
        }
      } catch (e) {
        emit(ProfileError('Failed to load user data: $e'));
      }
    });
  }
}
