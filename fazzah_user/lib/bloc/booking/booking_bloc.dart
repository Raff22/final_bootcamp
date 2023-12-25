import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<RequestProvidersEvent>((event, emit) async {
      print("2");
      emit(BookingLoadingState());
      try {
        final List<ProviderModel> providers =
            await SupaGetAndDelete().getAllProviders();
        print(providers);
        emit(ShowAllProvidersState(providersList: providers));
      } catch (error) {
        emit(BookingErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
