import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  int get itemCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextInt(1000).toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productExistentIndex = _items
        .indexWhere((existentProduct) => existentProduct.id == product.id);

    if (productExistentIndex != -1) {
      _items[productExistentIndex] = product;
    } else {
      addProduct(product);
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    final productExistentIndex = _items
        .indexWhere((existentProduct) => existentProduct.id == product.id);

    if (productExistentIndex >= 0) {
      _items.removeWhere((existentProduct) => existentProduct.id == product.id);
    notifyListeners();
    }
  }
}
