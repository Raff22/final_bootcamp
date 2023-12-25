import 'dart:convert';

class ProviderModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? idNumber;
  String? nationality;
  int? age;
  String? certificate;
  String? job;
  double? wallet;
  String? priceRange;
  String? experience;

  ProviderModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.idNumber,
    this.nationality,
    this.age,
    this.certificate,
    this.job,
    this.wallet,
    this.priceRange,
    this.experience,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> jsonData) {
    return ProviderModel(
      id: jsonData['id'],
      name: jsonData['name'],
      phoneNumber: jsonData['phone_number'],
      email: jsonData['email'],
      idNumber: jsonData['id_number'],
      nationality: jsonData['nationality'],
      age: jsonData['age'],
      certificate: jsonData['certificate'],
      job: jsonData['job'],
      wallet: jsonData['wallet'].toDouble(),
      priceRange: jsonData['price_range'],
      experience: jsonData['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'id_number': idNumber,
      'nationality': nationality,
      'age': age,
      'certificate': certificate,
      'job': job,
      'wallet': wallet,
      'price_range': priceRange,
      'experience': experience,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
