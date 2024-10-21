// home_state.dart
import 'package:equatable/equatable.dart';
import '../../../auth/model/login_model_class.dart';
import '../model/credit_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserData userData;
  final CreditData creditData;

  const HomeLoaded({required this.userData, required this.creditData});

  @override
  List<Object?> get props => [userData, creditData];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
