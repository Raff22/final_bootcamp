class Favorite {
  final int id;
  final String userId;
  final String providerId;

  Favorite({
    required this.id,
    required this.userId,
    required this.providerId,
  });

  factory Favorite.fromJson(Map<String, dynamic> jsonData) {
    return Favorite(
      id: jsonData['id'],
      userId: jsonData['user_id'],
      providerId: jsonData['provider_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provider_id': providerId,
    };
  }
}
