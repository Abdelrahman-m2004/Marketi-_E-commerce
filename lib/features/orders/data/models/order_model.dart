class OrderModel {
  final int id;
  final String orderNumber;
  final String status;
  final double total;
  final String date;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.total,
    required this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      status: json['status'] ?? '',
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      date: (json['created_at'] ?? '').toString().split('T').first,
    );
  }
}
