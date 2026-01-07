import 'package:mn/features/orders/domain/order_entity.dart';

class OrdersModel extends OrderEntity {
  final bool isDone;

  OrdersModel({
    required super.id,
    required super.userId,
    required super.product,
    required super.quantity,
    required super.created,
    this.isDone = false,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json['id'],
      userId: json['user_id'],
      product: json['product'],
      quantity: json['quantity'],
      created: DateTime.parse(json['created']),  // Fixed: parse DateTime
      isDone: json['is_done'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,  // Fixed: match fromJson key
      'product': product,
      'quantity': quantity,
      'created': created.toIso8601String(),  // Fixed: convert DateTime to String
      'is_done': isDone,
    };
  }

  // CopyWith method for updating isDone status
  OrdersModel copyWith({
    String? id,
    String? userId,
    String? product,
    int? quantity,
    DateTime? created,
    bool? isDone,
  }) {
    return OrdersModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      created: created ?? this.created,
      isDone: isDone ?? this.isDone,
    );
  }
}