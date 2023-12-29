import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';

import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<RequestAllUserOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        final Map<Order, ProviderModel> isDone =
            await SupaGetAndDelete().getDoneOrders();

        final Map<Order, ProviderModel> notDone =
            await SupaGetAndDelete().getNotDoneOrders();

        emit(ShowUserOrdersState(isDoneMap: isDone, notDoneMap: notDone));
      } catch (error) {
        print(error.toString());
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
