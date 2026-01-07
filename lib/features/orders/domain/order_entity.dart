abstract class OrderEntity {
  final String id;
  final String userId;
  final String product;
  final int quantity;
  final DateTime created;


 OrderEntity({required this.id, required this.userId, required this.product, required this.quantity, required this.created});
}