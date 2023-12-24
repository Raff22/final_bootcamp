class Rating {
  int? id;
  String? provider;
  String? user;
  String? comment;
  int? rate;
  DateTime? createdAt;

  Rating(
      {this.id,
      this.provider,
      this.user,
      this.comment,
      this.rate,
      this.createdAt});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    user = json['user'];
    comment = json['comment'];
    rate = json['rate'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['user'] = user;
    data['comment'] = comment;
    data['rate'] = rate;
    data['created_at'] = createdAt;
    return data;
  }
}
