import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context, 'Meus Pedidos', null),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, _) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, index) => OrderItem(order: orders.items[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
