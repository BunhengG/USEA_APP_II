import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/fetch_Payment.dart';
import '../../../helpers/shared_pref_helper.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    // Registering the FetchPayments event handler
    on<FetchPayments>((event, emit) async {
      emit(PaymentLoading());
      try {
        String? studentId = await SharedPrefHelper.getStudentId();
        String? password = await SharedPrefHelper.getPassword();

        if (studentId != null && password != null) {
          var paymentData = await PaymentService().fetchPaymentData(studentId, password);
          var otherPaymentData = await PaymentService().fetchOtherPaymentData(studentId, password);

          emit(PaymentLoaded(paymentData: paymentData, otherPaymentData: otherPaymentData));
        } else {
          emit(PaymentError(message: "No student ID or password found in SharedPreferences"));
        }
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });
  }
}
