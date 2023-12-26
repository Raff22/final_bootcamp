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
  num? wallet;
  String? priceRange;
  String? experience;
  String? providerImage;
  num? rateAverage;
  int? ratesNumber;
  String? services;

  ProviderModel(
      {this.id,
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
      this.providerImage,
      this.rateAverage,
      this.ratesNumber,
      this.services});

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
        wallet: jsonData['wallet'],
        priceRange: jsonData['price_range'],
        experience: jsonData['experience'],
        providerImage: jsonData['profile_image'],
        rateAverage: jsonData['rating_average'],
        services: jsonData['services'],
        ratesNumber: jsonData['rate_number']);
  }

  Map<String, dynamic> toJson() {
    return {
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
      'profile_image': providerImage,
      'rating_average': rateAverage,
      'services': services,
      'rate_number': ratesNumber
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
