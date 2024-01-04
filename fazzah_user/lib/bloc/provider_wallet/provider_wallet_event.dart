abstract class WalletEvent {}

class RequestallWalletmentsEvent extends WalletEvent {}

class RequestallWalletFirstEvent extends WalletEvent {
  final String id;

  RequestallWalletFirstEvent({required this.id});
}
