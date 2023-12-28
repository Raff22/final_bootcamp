import 'dart:convert';

class Order {
  int? id;
  String? provider;
  String? user;
  String? orderType;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  num? total;
  bool? isDone;

  Order(
      {this.id,
      this.provider,
      this.user,
      this.orderType,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.total,
      this.isDone});

  factory Order.fromJson(Map<String, dynamic> jsonData) {
    return Order(
        id: jsonData['id'],
        provider: jsonData['provider'],
        user: jsonData['user'],
        orderType: jsonData['order_type'],
        orderTime: jsonData['order_time'],
        orderDate: jsonData['order_date'],
        orderStatus: jsonData['order_status'],
        total: jsonData['total'],
        isDone: jsonData['is_done']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'user': user,
      'order_type': orderType,
      'order_time': orderTime,
      'order_date': orderDate,
      'order_status': orderStatus,
      'total': total,
      'is_done': isDone,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
