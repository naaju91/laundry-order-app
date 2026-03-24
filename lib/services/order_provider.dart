
import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/db_helper.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  // LOAD FROM DB
  Future<void> loadOrders() async {
    _orders = await DBHelper.instance.getOrders();
    notifyListeners();
  }

  // ADD ORDER
  Future<void> addOrder(Order order) async {
	await DBHelper.instance.insertOrder(order);
	await loadOrders();
	notifyListeners();
  }

  // UPDATE ORDER
  Future<void> updateOrder(Order order) async {
	await DBHelper.instance.updateOrder(order);
	await loadOrders();
	notifyListeners();
  }
}