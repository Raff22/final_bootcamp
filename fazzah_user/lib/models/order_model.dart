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
  int? paymentMethod;
  int? address;

  Order(
      {this.id,
      this.provider,
      this.user,
      this.orderType,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.total,
      this.isDone,
      this.paymentMethod,
      this.address});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    user = json['user'];
    orderType = json['order_type'];
    orderTime = json['order_time'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    total = json['total'];
    isDone = json['is_done'];
    paymentMethod = json['payment_method'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['provider'] = provider;
    data['user'] = user;
    data['order_type'] = orderType;
    data['order_time'] = orderTime;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['total'] = total;
    data['is_done'] = isDone;
    data['payment_method'] = paymentMethod;
    data['address'] = address;
    return data;
  }
}
