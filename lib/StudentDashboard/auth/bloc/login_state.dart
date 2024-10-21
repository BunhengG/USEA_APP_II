/* 


  this file will manages the different states (initial, loading, success, failure).


*/
import 'package:equatable/equatable.dart';
import '../model/login_model_class.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

// Successful login state, storing student user and user data
class LoginSuccess extends LoginState {
  final StudentUsers studentUser;
  final UserData userData;

  LoginSuccess({required this.studentUser, required this.userData});

  @override
  List<Object?> get props => [studentUser, userData];
}

// Login failure state with error message
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
