import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mn/features/orders/data/models/order_model.dart';

class OrdersRepository {
  List<OrdersModel> orders = [];
  
  static const String _ordersKey = 'orders';

  Future<void> init() async {
    await _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey);
    
    if (ordersJson != null) {
      orders = ordersJson
          .map((json) => OrdersModel.fromJson(jsonDecode(json)))
          .toList();
    }
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = orders.map((order) => jsonEncode(order.toJson())).toList();
    await prefs.setStringList(_ordersKey, ordersJson);
  }

  List<OrdersModel> getOrders() => orders;

  Future<void> createOrder(OrdersModel order) async {
    orders.add(order);
    await _saveOrders();
  }

  Future<void> markAsDone(String id) async {
    final index = orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      final order = orders[index];
      orders[index] = order.copyWith(isDone: !order.isDone);
      await _saveOrders();
    }
  }

  Future<void> deleteOrder(String id) async {
    orders.removeWhere((o) => o.id == id);
    await _saveOrders();
  }
}