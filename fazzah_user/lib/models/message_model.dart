class Message {
  int? id;
  String? createdAt;
  String? content;
  String? fromUser;
  String? toUser;
  bool? isMine;

  Message({this.id, this.createdAt, this.content, this.fromUser, this.toUser});

  Message.fromJson(Map<String, dynamic> json, String currentUserId) {
    id = json['id'];
    createdAt = json['created_at'];
    content = json['content'];
    fromUser = json['from_user'];
    toUser = json['to_user'];
    isMine = json['from_user'] == currentUserId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['content'] = content;
    data['from_user'] = fromUser;
    data['to_user'] = toUser;
    return data;
  }
}
