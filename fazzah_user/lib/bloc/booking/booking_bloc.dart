import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabase_add.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:fazzah_user/utils/helpers/map_splitter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<RequestProvidersEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final Map<ProviderModel, bool> providers =
            await SupaGetAndDelete().getAllProvidersFavs();
        final List<ProviderModel> x = splitMapToKeyList(providers);
        final List<bool> y = splitMapToValueList(providers);
        emit(ShowAllProvidersState(providers: x, favs: y));
      } catch (error) {
        print(error.toString());
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestProviderRatingsEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final List<Rating> ratings = await SupaGetAndDelete()
            .getProviderRatings(providerId: event.providerId);
        emit(ShowProviderRatingsState(ratings: ratings));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<SelectedServiceEvent>((event, emit) async {
      List<bool> selected = List.generate(services.length, (index) => false);
      selected[event.index] = true;
      emit(ShowSelectedServiceState(newSelected: selected));
    });
    on<GetProviderHoursEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final WorkingHours hours = await SupaGetAndDelete()
            .getProviderWorkingHours(providerId: event.providerId);
        emit(ShowProviderWorkingHoursState(hours: hours));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<SelectedHourEvent>((event, emit) async {
      List<bool> selected = List.generate(hours.length, (index) => false);
      selected[event.index] = true;
      emit(ShowSelectedHourState(newSelected: selected));
    });
    on<RequestProvidersByNameEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final Map<ProviderModel, bool> providers =
            await SupaGetAndDelete().getProvidersByName(event.name);
        final List<ProviderModel> x = splitMapToKeyList(providers);
        final List<bool> y = splitMapToValueList(providers);
        emit(ShowAllProvidersState(providers: x, favs: y));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestProvidersByServiceEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final Map<ProviderModel, bool> providers =
            await SupaGetAndDelete().getProvidersByService(event.service);
        final List<ProviderModel> x = splitMapToKeyList(providers);
        final List<bool> y = splitMapToValueList(providers);
        emit(ShowAllProvidersState(providers: x, favs: y));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestUserPaymentMethodsEvent>((event, emit) async {
      try {
        final List<PaymentMethod> methods =
            await SupaGetAndDelete().getUserPaymentMethods();
        emit(ShowUserPaymentMethodsState(
            paymentMethodsList: methods,
            selectedPayments: List.generate(methods.length, (index) => false)));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<SelectPaymentMethodEvent>((event, emit) async {
      try {
        final List<PaymentMethod> methods =
            await SupaGetAndDelete().getUserPaymentMethods();
        List<bool> bools = List.generate(methods.length, (index) => false);
        bools[event.index] = true;
        emit(ShowUserPaymentMethodsState(
            paymentMethodsList: methods, selectedPayments: bools));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<CreateOrderEvent>((event, emit) async {
      final selectedServiceIndex =
          event.servicesSelected.indexWhere((element) => element == true);
      final selectedHourIndex =
          event.hoursSelected.indexWhere((element) => element == true);
      final paymentMethodIndex =
          event.selectedPayments.indexWhere((element) => element == true);
      if (selectedServiceIndex < 0) {
        emit(
            BookingErrorState(error: "من فضلك اختر الخدمة حتى تتمكن من الحجز"));
      }
      if (selectedHourIndex < 0) {
        emit(
            BookingErrorState(error: "من فضلك اختر الساعة حتى تتمكن من الحجز"));
      }
      if (paymentMethodIndex < 0) {
        emit(BookingErrorState(
            error: "من فضلك اختر طريق الدفع حتى تتمكن من الحجز"));
      } else {
        emit(BookingLoadingState());
        try {
          double num1 = double.parse(event.provider.priceRange!.split('-')[0]);
          double num2 = double.parse(event.provider.priceRange!.split('-')[1]);
          double avg = num1 + num2;
          avg = avg * 0.5;
          Order newOrder = Order(
              total: avg,
              provider: event.provider.id,
              orderType: services[selectedServiceIndex],
              orderDate: event.date.toIso8601String(),
              orderTime: hours[selectedHourIndex],
              orderStatus: "مؤكد",
              paymentMethod: event.userPaymentMethods[paymentMethodIndex].id!);
          final Order? verfied = await SupaAdd().addNewOrder(newOrder);
          if (verfied != null) {
            emit(CreatedOrderSuccessfly(newOrder: newOrder));
          } else {
            emit(BookingErrorState(error: "حدث خطأ في النظام"));
          }
        } catch (error) {
          emit(BookingErrorState(error: "حدث خطأ في النظام"));
        }
      }
    });
  }
}
