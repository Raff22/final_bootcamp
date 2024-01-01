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
        // final List<ProviderModel> providers =
        //     await SupaGetAndDelete().getAllProviders();

        final List<ProviderModel> isdone =
            await SupabaseUpdate().updateProviderWallet();
        // print("providers $providers");

        emit(ShowAllWalletmentsState(isdone: isdone));
      } catch (error) {
        print(error.toString());
        emit(WalletErrorState(error: "حدث خطأ في النظام"));
      }
    });
  }
}
