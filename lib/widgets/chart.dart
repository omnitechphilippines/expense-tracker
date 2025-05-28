import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues => List<Map<String, Object>>.generate(7, (int idx) {
        final DateTime weekDay = DateTime.now().subtract(Duration(days: idx));
        double totalSum = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day && recentTransactions[i].date.month == weekDay.month && recentTransactions[i].date.year == weekDay.year) totalSum += recentTransactions[i].amount;
        }
        return <String, Object>{'day': DateFormat.E().format(weekDay).substring(0, 2), 'amount': totalSum};
      }).reversed.toList();

  double get totalSpending => groupedTransactionValues.fold(0.0, (double sum, Map<String, Object> item) => sum + (item['amount'] as double));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map((Map<String, Object> data) => Flexible(fit: FlexFit.tight, child: ChartBar(label: data['day'] as String, spendingAmount: data['amount'] as double, spendingPctOfTotal: totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending)))
              .toList(),
        ),
      ),
    );
  }
}
