/* 


  This file will handles the button press event.


*/

// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event when the login button is pressed
class LoginButtonPressed extends LoginEvent {
  final String studentId;
  final String password;

  LoginButtonPressed({required this.studentId, required this.password});

  @override
  List<Object> get props => [studentId, password];
}

// Event to check if the user is already logged in
class CheckIfLoggedIn extends LoginEvent {}

