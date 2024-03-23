import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/endpoints.dart';
import 'package:shop/utils/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();

    await http
        .patch(
      Uri.parse('${Endpoints.PRODUCTS}/${id}.json'),
      body: jsonEncode({
        "isFavorite": isFavorite,
      }),
    ).then((response) {
      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
        throw HttpException(
          message: 'Não foi possível favoritar o produto!',
          statusCode: response.statusCode,
        );
      }
    });
  }
}
