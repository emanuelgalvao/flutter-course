import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/product_details_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.purple,
            colorScheme:
                theme.colorScheme.copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato'),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAILS: (_) => const ProductDetailsPage(),
          AppRoutes.CART: (_) => const CartPage(),
        },
      ),
    );
  }
}
