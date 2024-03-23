import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';
import 'package:shop/utils/endpoints.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    final response = await http.get(Uri.parse(Endpoints.ORDERS));

    if (response.body == 'null') {
      return;
    }

    _items.clear();
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach(
      (orderId, orderData) {
        _items.add(
          Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>).map(
              (product) {
                return CartItem(
                  id: product['id'],
                  productId: product['id'],
                  quantity: product['quantity'],
                  name: product['name'],
                  price: product['price'],
                );
              },
            ).toList(),
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final response = await http.post(
      Uri.parse(Endpoints.ORDERS),
      body: jsonEncode(
        {
          "total": cart.totalAmount,
          "date": DateTime.now().toIso8601String(),
          "products": cart.items.values
              .map(
                (product) => {
                  "id": product.id,
                  "productId": product.productId,
                  "name": product.name,
                  "quantity": product.quantity,
                  "price": product.price
                },
              )
              .toList()
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Order(
        id: id,
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.items.values.toList(),
      ),
    );
  }
}
