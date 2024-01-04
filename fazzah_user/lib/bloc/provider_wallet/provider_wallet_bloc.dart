import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_event.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_state.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/models/provider_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<RequestallWalletmentsEvent>((event, emit) async {
      emit(WalletLoadingState());
      try {
        final num res = await SupabaseUpdate().updateProviderWallet();

        emit(ShowAllWalletmentsState(newWallet: res));
      } catch (error) {
        print(error.toString());
        emit(WalletErrorState(error: "حدث خطأ في النظام"));
      }
    });

    on<RequestallWalletFirstEvent>((event, emit) async {
      emit(WalletLoadingState());
      try {
        final ProviderModel res = await SupaGet().getProvider(event.id);

        emit(ShowAllWalletmentsState(newWallet: res.wallet ?? 0));
      } catch (error) {
        print(error.toString());
        emit(WalletErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
