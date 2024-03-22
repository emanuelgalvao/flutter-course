import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((_, item) {
      total += (item.price * item.quantity);
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existentItem) => CartItem(
          id: existentItem.id,
          productId: existentItem.id,
          name: existentItem.name,
          quantity: existentItem.quantity + 1,
          price: existentItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextInt(1000).toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (_items[id]?.quantity == 1) {
      removeItem(id);
    } else {
      _items.update(
        id,
        (existentItem) => CartItem(
          id: existentItem.id,
          productId: existentItem.id,
          name: existentItem.name,
          quantity: existentItem.quantity - 1,
          price: existentItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
