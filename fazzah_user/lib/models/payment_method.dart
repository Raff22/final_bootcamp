class PaymentMethod {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? expiresAt;
  int? cardNumber;

  PaymentMethod(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.expiresAt,
      this.cardNumber});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    expiresAt = json['expires_at'];
    cardNumber = json['card_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['expires_at'] = expiresAt;
    data['card_number'] = cardNumber;
    return data;
  }
}
