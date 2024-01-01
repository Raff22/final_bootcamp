import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/database/delete_data.dart';

import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabase_add.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<RequestAllUserOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        final Map<Order, ProviderModel> isDone =
            await SupaGet().getDoneOrders();

        final Map<Order, ProviderModel> notDone =
            await SupaGet().getNotDoneOrders();

        emit(ShowUserOrdersState(isDoneMap: isDone, notDoneMap: notDone));
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestAllProviderOrdersEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        final Map<Order, UserModel> isDone =
            await SupaGet().getDoneOrdersProvider();

        final Map<Order, UserModel> notDone =
            await SupaGet().getNotDoneOrdersProvider();
        emit(ShowProviderOrdersState(isDoneMap: isDone, notDoneMap: notDone));
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });

    on<RequestOrderRelaitedInfoEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        final Address address =
            await SupaGet().getAddressesById(id: event.addressID);
        final PaymentMethod payment =
            await SupaGet().getPaymentMethodById(id: event.paymentMethodID);

        emit(ShowOrderRelatiedInfo(address: address, paymentMethod: payment));
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<PayingEvent>((event, emit) async {
      // emit(OrderLoadingState());
      event.provider.wallet = event.provider.wallet ?? 0;
      event.provider.wallet = event.provider.wallet! + event.order.total!;
      event.order.isDone = true;
      event.order.orderStatus = "منتهي";
      try {
        await SupabaseUpdate().updateOrder(event.order, event.provider);
        final UserModel user = await SupaGet().getCurrentUser();
        print("here");
        emit(PaymentCompletedSuccessfully(user: user));
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<DeleteOrderEvent>((event, emit) async {
      try {
        await SupabaseDelete().deleteOrder(event.orderId);
        print("here");
        final UserModel user = await SupaGet().getCurrentUser();
        emit(DeletedOrderSuccessfully(user: user));
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RatingAddingEvent>((event, emit) async {
      emit(OrderLoadingState());
      try {
        await SupaAdd().addRating(event.rating, event.provider);
        emit(RatingAddedSuccessfully());
      } catch (error) {
        emit(OrderErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
