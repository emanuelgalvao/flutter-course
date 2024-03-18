import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber
        ),
        fontFamily: 'Quicksand',
        appBarTheme: theme.appBarTheme.copyWith(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        textTheme: theme.textTheme.copyWith(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    setState(() {
      _transactions.add(
        Transaction(
          id: Random().nextDouble().toString(), 
          title: title, 
          value: value, 
          date: date
        )
      );
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm(onAddTransaction: _addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context), 
          icon: Icon(Icons.add)
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final availableHeight = MediaQuery.of(context).size.height 
      - appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: availableHeight * 0.2,
              child: Chart(_recentTransactions)
            ),
            Container(
              height: availableHeight * 0.8,
              child: TransactionList(
                transactions: _transactions,
                removeTransaction: _removeTransaction,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}