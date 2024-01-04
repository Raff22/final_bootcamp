abstract class WalletState {}

class WalletInitial extends WalletState {}

class ShowAllWalletmentsState extends WalletState {
  final num newWallet;

  ShowAllWalletmentsState({required this.newWallet});
}

class WalletErrorState extends WalletState {
  final String error;

  WalletErrorState({required this.error});
}

class WalletLoadingState extends WalletState {}
