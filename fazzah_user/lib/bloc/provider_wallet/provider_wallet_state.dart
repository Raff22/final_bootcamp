abstract class WalletState {}

class WalletInitial extends WalletState {}

class ShowAllWalletmentsState extends WalletState {}

class WalletErrorState extends WalletState {
  final String error;

  WalletErrorState({required this.error});
}

class WalletLoadingState extends WalletState {}
