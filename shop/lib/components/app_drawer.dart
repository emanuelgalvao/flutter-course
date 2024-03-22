import 'package:flutter/material.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        customAppbar(context, 'Bem-vindo!', null),
        const SizedBox(height: 10,),
        ListTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Loja'),
          onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text('Pedidos'),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.ORDERS),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Gerenciar Produtos'),
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.MANAGE_PRODUCTS),
        ),
        const Divider(),
      ]),
    );
  }
}