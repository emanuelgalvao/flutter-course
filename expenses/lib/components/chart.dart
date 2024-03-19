import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {

    final groupedByDays = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      double totalSum = 0.0;

      for (var transaction in _recentTransactions) {
        final sameDay = weekDay.day == transaction.date.day;
        final sameMonth = weekDay.month == transaction.date.month;
        final sameYear = weekDay.year == transaction.date.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });

    return groupedByDays.reversed.toList();
  }

  double get _weekTotalValue {
    return _groupedTransactions.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item['value'].toString()) ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((transaction) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: transaction['day'].toString(), 
                  value: double.tryParse(transaction['value'].toString()) ?? 0.0, 
                  percentage: _weekTotalValue == 0 ? 0 : (double.tryParse(transaction['value'].toString()) ?? 0.0) / _weekTotalValue
                ),
              );
          }).toList(),
        ),
      ),
    );
  }
}