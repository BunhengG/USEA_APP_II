// Event
import 'package:equatable/equatable.dart';

// Event
abstract class PerformanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPerformanceData extends PerformanceEvent {}
