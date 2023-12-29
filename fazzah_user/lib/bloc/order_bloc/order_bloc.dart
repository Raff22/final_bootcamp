import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';

import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<RequestallProvidersEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        // final List<ProviderModel> providers =
        //     await SupaGetAndDelete().getAllProviders();
        final List<ProviderModel> notdone =
            await SupaGetAndDelete().getOrderNotDone();
        final List<ProviderModel> isdone =
            await SupaGetAndDelete().getOrderDone();
        // print("providers $providers");

        emit(ShowAllProvidersState(isdonelist: isdone, notdonelist: notdone));
      } catch (error) {
        print(error.toString());
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
