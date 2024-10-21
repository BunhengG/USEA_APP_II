// payment_state.dart
import '../model/payment_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PayStudy> paymentData;
  final List<OtherPayment> otherPaymentData;

  PaymentLoaded({required this.paymentData, required this.otherPaymentData});
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({required this.message});
}
