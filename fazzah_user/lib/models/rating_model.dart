class Rating {
  int? id;
  String? provider;
  String? user;
  String? comment;
  int? rate;
  String? userName;
  String? createdAt;

  Rating(
      {this.id,
      this.provider,
      this.user,
      this.comment,
      this.rate,
      this.createdAt,
      this.userName});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    user = json['user'];
    comment = json['comment'];
    rate = json['rate'];
    createdAt = json['created_at'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider'] = provider;
    data['user'] = user;
    data['comment'] = comment;
    data['rate'] = rate;
    data['created_at'] = createdAt;
    data['user_name'] = userName;
    return data;
  }
}
