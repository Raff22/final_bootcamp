import 'dart:convert';

class ProviderModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String idNumber;
  final String nationality;
  final int age;
  final String certificate;
  final String job;
  final double wallet;
  final String priceRange;
  final String experience;

  ProviderModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.idNumber,
    required this.nationality,
    required this.age,
    required this.certificate,
    required this.job,
    required this.wallet,
    required this.priceRange,
    required this.experience,
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
