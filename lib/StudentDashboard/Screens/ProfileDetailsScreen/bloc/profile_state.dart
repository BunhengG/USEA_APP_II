// profile_state.dart
import 'package:equatable/equatable.dart';
import '../../../auth/model/login_model_class.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserData userData;

  ProfileLoaded(this.userData);

  @override
  List<Object?> get props => [userData];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
