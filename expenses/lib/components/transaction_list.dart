import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function (String) removeTransaction;

  TransactionList({
    required this.transactions,
    required this.removeTransaction
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(
      children: [
        Text(
          'Nenhuma transação cadastrada!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
        Container(
          child: Image.asset('assets/images/waiting.png'),
          height: 200,
        )
      ],
    ) : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8
          ),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      "R\$ ${transaction.value.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(DateFormat('d MMM y').format(transaction.date)),
              trailing: IconButton(
                onPressed: () => removeTransaction(transaction.id),
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        );
      }
    );
  }
}