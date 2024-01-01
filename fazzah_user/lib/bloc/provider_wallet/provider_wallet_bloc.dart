import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_event.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_state.dart';
import 'package:fazzah_user/database/update_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<RequestallWalletmentsEvent>((event, emit) async {
      emit(WalletLoadingState());
      try {
        await SupabaseUpdate().updateProviderWallet();
        // print("providers $providers");

        emit(ShowAllWalletmentsState());
      } catch (error) {
        print(error.toString());
        emit(WalletErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
