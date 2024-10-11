import 'dart:convert';

import 'order_database.dart';
import '../model/order_model.dart';

class OrderDbHelper {
  OrderDatabase instance = OrderDatabase.instance;

  Future<void> createOrder(Order order) async {
    final db = await instance.database;
    await db.insert('orders', order.toJson());
  }

  Future<Order?> getOrder(String orderNo) async {
    final db = await instance.database;
    final maps = await db.query(
      'orders',
      where: 'orderNo = ?',
      whereArgs: [orderNo],
    );

    if (maps.isNotEmpty) {
      return Order.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<Order?> getOrderByOrderId(int orderId) async {
    final db = await instance.database;
    final maps = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [orderId],
    );
    if(maps.isNotEmpty) {
      return Order.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Order>?> getOrdersByBuyerName(String buyerName) async {
    print(buyerName);
    final db = await instance.database;
    final maps = await db.query(
      'orders',
      where: 'buyerName = ?',
      whereArgs: [buyerName],
    );
    if (maps.isNotEmpty) {
      List<Order> orders = maps.map((orderJson) {
        return Order.fromJson(orderJson);
      }).toList();
      return orders.toList();
    } else {
      return null;
    }
  }

  Future<List<Order>> getAllOrders() async {
    final db = await instance.database;
    final result = await db.query('orders');
    return result.map((json) {
      if(json['runningMachine'] != null) {
        print(jsonDecode(json['runningMachine'] as String));
      }
      return Order.fromJson(json);
    }).toList();
  }

  Future<int> updateOrder(Order order) async {
    final db = await instance.database;
    return db.update(
      'orders',
      order.toJson(),
      where: 'orderNo = ?',
      whereArgs: [order.orderNo],
    );
  }

  Future<int> deleteOrder(String orderNo) async {
    final db = await instance.database;
    return db.delete(
      'orders',
      where: 'orderNo = ?',
      whereArgs: [orderNo],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}