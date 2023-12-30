class PaymentMethod {
  int? id;
  String? userId;
  String? name;
  String? email;
  String? cardNumber;
  String? expiresAt;
  String? cardname;

  PaymentMethod(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.cardNumber,
      this.expiresAt,
      this.cardname});
  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    expiresAt = json['expires_at'];
    cardNumber = json['card_number'];
    cardname = json['card_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userId != null) {
      data['user_id'] = userId;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (cardNumber != null) {
      data['card_number'] = cardNumber;
    }
    if (expiresAt != null) {
      data['expires_at'] = expiresAt;
    }
    if (cardname != null) {
      data['card_name'] = cardname;
    }
    // Notice that 'id' is not included here
    return data;
  }
}
