import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';

abstract class WalletState {}

class WalletInitial extends WalletState {}

class ShowAllWalletmentsState extends WalletState {
  final List<ProviderModel> isdone;

  ShowAllWalletmentsState({required this.isdone});
}

class WalletErrorState extends WalletState {
  final String error;

  WalletErrorState({required this.error});
}

class WalletLoadingState extends WalletState {}
