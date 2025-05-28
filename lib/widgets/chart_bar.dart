import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount, spendingPctOfTotal;

  const ChartBar({super.key, required this.label, required this.spendingAmount, required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) => Column(
        children: <Widget>[
          SizedBox(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text('₱${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(children: <Widget>[
                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1), color: const Color.fromRGBO(220, 220, 220, 1))),
                FractionallySizedBox(heightFactor: spendingPctOfTotal, child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)))),
              ])),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text(label))),
        ],
      ),
    );
  }
}
