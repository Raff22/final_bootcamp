import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<RequestProvidersEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final List<ProviderModel> providers =
            await SupaGetAndDelete().getAllProviders();
        emit(ShowAllProvidersState(providersList: providers));
      } catch (error) {
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
        final List<ProviderModel> providers =
            await SupaGetAndDelete().getProvidersByName(event.name);
        emit(ShowAllProvidersState(providersList: providers));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestProvidersByServiceEvent>((event, emit) async {
      emit(BookingLoadingState());
      try {
        final List<ProviderModel> providers =
            await SupaGetAndDelete().getProvidersByService(event.service);
        emit(ShowAllProvidersState(providersList: providers));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
    on<RequestUserPaymentMethodsEvent>((event, emit) async {
      emit(BookingLoadingState());
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
      emit(BookingLoadingState());
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
  }
}
