class PaymentModel {
  final int id;
  final String paymentNumber;
  final String amount;
  final String status;
  final String paymentMethod;
  final String gateway;
  final String? paymentUrl;
  final OrderModel order;

  PaymentModel({
    required this.id,
    required this.paymentNumber,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.gateway,
    this.paymentUrl,
    required this.order,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      paymentNumber: json['payment_number'],
      amount: json['amount'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      gateway: json['gateway'],
      paymentUrl: json['payment_url'],
      order: OrderModel.fromJson(json['order']),
    );
  }
}

class OrderModel {
  final int id;
  final String orderNumber;
  final String status;
  final String total;
  final String address;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.total,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      status: json['status'],
      total: json['total'],
      address: json['delivery_address'],
    );
  }
}
