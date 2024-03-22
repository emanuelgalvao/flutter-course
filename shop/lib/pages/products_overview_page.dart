import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/providers/product_list.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewPage extends StatefulWidget {
  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppbar(
        context,
        'Minha Loja',
        [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Apenas Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                switch (selectedValue) {
                  case FilterOptions.favorites:
                    _showOnlyFavorites = true;
                  case FilterOptions.all:
                    _showOnlyFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cart, _) => Badge(
              isLabelVisible: cart.itemCount > 0,
              label: Text(cart.itemCount.toString()),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                }, 
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
