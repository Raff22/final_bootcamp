class UserModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;

  UserModel({this.id, this.name, this.phoneNumber, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    return data;
  }
}
