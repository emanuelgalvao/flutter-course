import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date),
          ),
          trailing: IconButton(
            icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ),
        if (_isExpanded)
          Container(
            height: (widget.order.products.length * 25) + 10,
            child: ListView(
              children: widget.order.products.map((product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${product.quantity}x R\$ ${product.price}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          )
      ]),
    );
  }
}
