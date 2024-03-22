import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: customAppbar(
        context,
        'Gerenciar Produtos',
        [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: products.itemCount,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ProductItem(products.items[index]),
                const Divider(),
              ],
            );
          }),
    );
  }
}
