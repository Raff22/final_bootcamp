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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address_title'] = this.addressTitle;
    return data;
  }
}
