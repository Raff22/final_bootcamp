class Address {
  int? id;
  String? userId;
  String? address;
  String? city;
  double? latitude;
  double? longitude;
  String? addressTitle;

  Address(
      {this.id,
      this.userId,
      this.address,
      this.city,
      this.latitude,
      this.longitude,
      this.addressTitle});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressTitle = json['address_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['address'] = address;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address_title'] = addressTitle;
    return data;
  }
}
