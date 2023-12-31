abstract class UserEvent {}

class AddNewAddress extends UserEvent {
  final int? addressId;
  final String? userId;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? addressTitle;

  AddNewAddress(
      {this.addressId,
      this.userId,
      this.address,
      this.city,
      this.latitude,
      this.longitude,
      this.addressTitle});
}

class GetAllUserAddressEvent extends UserEvent {
  GetAllUserAddressEvent();
}

class DeleteUserAddressEvent extends UserEvent {
  final int addressID;
  DeleteUserAddressEvent(this.addressID);
}
