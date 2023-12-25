class Message {
  int? id;
  String? fromUser;
  String? toUser;
  String? message;
  DateTime? createdAt;

  Message({this.id, this.fromUser, this.toUser, this.message, this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUser = json['from_user'];
    toUser = json['to_user'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from_user'] = fromUser;
    data['to_user'] = toUser;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
