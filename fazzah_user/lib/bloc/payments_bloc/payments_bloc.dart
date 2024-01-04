import 'package:fazzah_user/bloc/payments_bloc/payments_event.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_state.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayInitial()) {
    on<RequestallPaymentsEvent>((event, emit) async {
      try {
        final List<PaymentMethod> isdone =
            await SupaGet().getUserPaymentMethods();

        emit(ShowAllPaymentsState(isdonelist: isdone));
      } catch (error) {
        emit(PayErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
