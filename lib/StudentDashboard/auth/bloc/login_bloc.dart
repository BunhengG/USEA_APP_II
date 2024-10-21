/* 


  This file will processes the login event and updates the state based on the response.


*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../api/fetch_user.dart';
import '../../helpers/shared_pref_helper.dart';
import '../model/login_model_class.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // Handle login button press
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      // Call your login function
      UserDataResponse? response =
          await loginStudent(event.studentId, event.password);

      if (response != null && response.studentUsers.isNotEmpty) {
        // Retrieve student user and user data from API response
        StudentUsers studentUser = response.studentUsers[0];
        UserData userData = response.userData[0];

        // Save user data in SharedPreferences
        await SharedPrefHelper.saveStudentIdAndPassword(
            studentUser.studentId, studentUser.pwd);
        await SharedPrefHelper.saveUserData(studentUser, userData);

        // Emit success state
        emit(LoginSuccess(studentUser: studentUser, userData: userData));
      } else {
        // Emit failure state with error message
        emit(
          LoginFailure(
              error:
                  'អត្តលេខនិស្សិត ឬពាក្យសម្ងាត់មិនត្រឹមត្រូវ។ សូមបញ្ចូលម្ដងទៀត!!!'
                      .tr),
        );
      }
    });

    // Handle checking if user is already logged in
    on<CheckIfLoggedIn>((event, emit) async {
      emit(LoginLoading());

      // Retrieve stored data from SharedPreferences
      StudentUsers? storedUser = await SharedPrefHelper.getStoredStudentUser();
      UserData? storedUserData = await SharedPrefHelper.getStoredUserData();

      if (storedUser != null && storedUserData != null) {
        // Emit success state if user is already logged in
        emit(LoginSuccess(studentUser: storedUser, userData: storedUserData));
      } else {
        emit(LoginInitial());
      }
    });
  }
}
