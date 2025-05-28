import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) deleteTransaction;
  final bool isDarkMode;

  const TransactionList({super.key, required this.transactions, required this.deleteTransaction, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext ctx, int idx) => Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(radius: 30, child: Padding(padding: const EdgeInsets.all(8), child: FittedBox(child: Text('₱${transactions[idx].amount.toStringAsFixed(2)}', style: const TextStyle(fontFamily: 'Quicksand'))))),
                    title: Text(transactions[idx].title, style: TextStyle(color: isDarkMode ? Colors.white : const Color(0xFF1F1A1F), fontWeight: FontWeight.bold)),
                    subtitle: Text(DateFormat.yMMMd().format(transactions[idx].date)),
                    trailing: MediaQuery.sizeOf(context).width > 460
                        ? TextButton.icon(onPressed: () => deleteTransaction(transactions[idx].id), label: Text('Delete', style: TextStyle(color: kColorScheme.error, fontWeight: FontWeight.bold)), icon: Icon(Icons.delete, color: kColorScheme.error))
                        : IconButton(onPressed: () => deleteTransaction(transactions[idx].id), icon: Icon(Icons.delete, color: kColorScheme.error)),
                  ),
                )
            //     Card(
            //   child: Row(
            //     children: [
            //       Container(
            //         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
            //         child: Text('\$${transactions[idx].amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor)),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [Text(transactions[idx].title, style: Theme.of(context).textTheme.titleMedium), Text(DateFormat.yMMMd().format(transactions[idx].date), style: const TextStyle(color: Colors.grey))],
            //       )
            //     ],
            //   ),
            // ),
            )
        : LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) =>
                Column(children: <Widget>[Text('No transactions added yet!', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 20), SizedBox(height: constraints.maxHeight * 0.6, child: Image.asset('assets/images/waiting.png'))]));
  }
}
