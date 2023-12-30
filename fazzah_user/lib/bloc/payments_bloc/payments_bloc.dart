import 'package:fazzah_user/bloc/payments_bloc/payments_event.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_state.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayInitial()) {
    on<RequestallPaymentsEvent>((event, emit) async {
      emit(PayLoadingState());
      try {
        // final List<ProviderModel> providers =
        //     await SupaGetAndDelete().getAllProviders();

        final List<PaymentMethod> isdone =
            await SupaGetAndDelete().getUserPaymentMethods();
        // print("providers $providers");

        emit(ShowAllPaymentsState(isdonelist: isdone));
      } catch (error) {
        print(error.toString());
        emit(PayErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
