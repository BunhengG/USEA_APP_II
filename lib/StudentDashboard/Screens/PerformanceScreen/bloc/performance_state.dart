// States
import 'package:equatable/equatable.dart';

import '../model/performance_model.dart';

// States
abstract class PerformanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PerformanceInitial extends PerformanceState {}

class PerformanceLoading extends PerformanceState {}

class PerformanceLoaded extends PerformanceState {
  final List<PerformanceClass> performances;

  PerformanceLoaded(this.performances);

  @override
  List<Object?> get props => [performances];
}

class PerformanceError extends PerformanceState {
  final String message;

  PerformanceError(this.message);

  @override
  List<Object?> get props => [message];
}
