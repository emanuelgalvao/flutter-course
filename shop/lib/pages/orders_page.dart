import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/components/order_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/order_list.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = Provider.of<OrderList>(context).items;

    return Scaffold(
      appBar: customAppbar(context, 'Meus Pedidos', null),
      body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (ctx, index) {
            return OrderItem(order: orders[index]);
          }),
    );
  }
}
