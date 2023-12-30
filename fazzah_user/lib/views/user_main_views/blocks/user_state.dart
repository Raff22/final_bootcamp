import 'package:fazzah_user/models/address.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingState extends UserState {}

class UpdateState extends UserState {}

class AllUserAddressState extends UserState {
  final List<Address> address;

  AllUserAddressState(this.address);
}

class ErrorState extends UserState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}

