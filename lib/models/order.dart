
class Order {
  int id;
  String orderId;
  String name;
  String phone;
  String service;
  int items;
  double price;
  double total;
  String status;

  Order({
    required this.id,
    required this.orderId,
    required this.name,
    required this.phone,
    required this.service,
    required this.items,
    required this.price,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'name': name,
      'phone': phone,
      'service': service,
      'items': items,
      'price': price,
      'total': total,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      orderId: map['orderId'],
      name: map['name'],
      phone: map['phone'],
      service: map['service'],
      items: map['items'],
      price: map['price'],
      total: map['total'],
      status: map['status'],
    );
  }
}