import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/endpoints.dart';
import 'package:shop/utils/http_exception.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  int get itemCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse('${Endpoints.PRODUCTS}.json'));
    if (response.body == 'null') {
      return;
    }
    _items.clear();
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach(
      (productId, productData) {
        _items.add(
          Product(
            id: productId,
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextInt(1000).toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('${Endpoints.PRODUCTS}.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final productExistentIndex = _items
        .indexWhere((existentProduct) => existentProduct.id == product.id);

    if (productExistentIndex != -1) {
      await http.patch(
        Uri.parse('${Endpoints.PRODUCTS}/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[productExistentIndex] = product;
      notifyListeners();
    } else {
      addProduct(product);
    }
  }

  Future<void> removeProduct(Product product) async {
    final productExistentIndex = _items
        .indexWhere((existentProduct) => existentProduct.id == product.id);

    if (productExistentIndex >= 0) {
      _items.removeWhere((existentProduct) => existentProduct.id == product.id);
      notifyListeners();

      await http
          .delete(
        Uri.parse('${Endpoints.PRODUCTS}/${product.id}.json'),
      ).then((response) {
        if (response.statusCode >= 400) {
          _items.insert(productExistentIndex, product);
          notifyListeners();
          throw HttpException(
            message: 'Não foi possível excluir o produto!',
            statusCode: response.statusCode,
          );
        }
      });
    }
  }
}
