abstract class UserEvent {}

class AddNewAddress extends UserEvent {
  final String? userId;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final String? addressTitle;

  AddNewAddress(
      {this.userId,
      this.address,
      this.city,
      this.latitude,
      this.longitude,
      this.addressTitle});
}
