import 'package:flutter/material.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context)?.settings.arguments as Product;

    return Scaffold(
      appBar: customAppbar(context, product.name, null),
    );
  }
}