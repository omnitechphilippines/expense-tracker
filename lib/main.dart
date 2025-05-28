import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);
ColorScheme kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(foregroundColor: kColorScheme.primaryContainer, backgroundColor: kColorScheme.onPrimaryContainer, titleTextStyle: const TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold)),
        // fontFamily: 'Quicksand',
        // cardTheme: CardTheme(color: kColorScheme.secondaryContainer, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
        // elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: kColorScheme.primaryContainer)),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, color: kColorScheme.onSecondaryContainer, fontSize: 20),
          titleMedium: const TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold, fontSize: 18),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: kColorScheme.onPrimaryContainer, backgroundColor: kColorScheme.primaryContainer, shape: const CircleBorder()),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // appBarTheme: AppBarTheme(foregroundColor: kDarkColorScheme.primaryContainer, backgroundColor: kDarkColorScheme.onPrimaryContainer),
        cardTheme: CardTheme(color: kDarkColorScheme.secondaryContainer, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(foregroundColor: kDarkColorScheme.onPrimaryContainer, backgroundColor: kDarkColorScheme.primaryContainer)),
        textTheme: TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.bold, color: kDarkColorScheme.onSecondaryContainer, fontSize: 16)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: kDarkColorScheme.onPrimaryContainer, backgroundColor: kDarkColorScheme.primaryContainer, shape: const CircleBorder()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = <Transaction>[Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()), Transaction(id: 't2', title: 'Weekly Groceries', amount: 16.53, date: DateTime.now())];
  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final Transaction newTransaction = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: date);
    setState(() => _transactions.add(newTransaction));
  }

  void _deleteTransaction(String id) {
    setState(() => _transactions.removeWhere((Transaction transaction) => transaction.id == id));
  }

  void _addNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(context: context, builder: (_) => NewTransaction(newTransaction: _addNewTransaction));
  }

  List<Transaction> get _recentTransactions => _transactions.where((Transaction transaction) => transaction.date.isAfter(DateTime.now().subtract(const Duration(days: 7)))).toList();

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.orientationOf(context);
    final EdgeInsets padding = MediaQuery.paddingOf(context);
    final Size size = MediaQuery.sizeOf(context);
    final bool isLandscape = orientation == Orientation.landscape;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final AppBar appBar = AppBar(title: Text('Personal Expenses', style: TextStyle(color: kColorScheme.onPrimary, fontSize: 20, fontFamily: 'Quicksand')), actions: <Widget>[IconButton(onPressed: () => _addNewTransactionModal(context), icon: const Icon(Icons.add))]);
    final CupertinoNavigationBar iosAppBar = CupertinoNavigationBar(middle: const Text('Personal Expenses'), trailing: GestureDetector(onTap: () => _addNewTransactionModal(context), child: const Icon(CupertinoIcons.add)));
    final SizedBox smallChartWidget = SizedBox(height: (size.height - appBar.preferredSize.height - padding.top) * 0.3, child: Chart(recentTransactions: _recentTransactions));
    final SizedBox bigChartWidget = SizedBox(height: (size.height - appBar.preferredSize.height - padding.top) * 0.7, child: Chart(recentTransactions: _recentTransactions));
    final SizedBox transactionWidget = SizedBox(height: (size.height - appBar.preferredSize.height - padding.top) * 0.7, child: TransactionList(transactions: _transactions, deleteTransaction: _deleteTransaction, isDarkMode: isDarkMode));
    final SafeArea body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape) smallChartWidget,
            if (!isLandscape) transactionWidget,
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: <Widget>[Text('Show Chart', style: TextStyle(color: isDarkMode ? kColorScheme.onPrimary : kDarkColorScheme.onPrimary, fontFamily: 'OpenSans', fontWeight: FontWeight.bold)), Switch.adaptive(value: _showChart, onChanged: (bool value) => setState(() => _showChart = value))],
              ),
            if (isLandscape) _showChart ? bigChartWidget : transactionWidget,
          ],
        ),
      ),
    );
    return kIsWeb || Platform.isAndroid || Platform.isWindows
        ? Scaffold(appBar: appBar, body: body, floatingActionButton: FloatingActionButton(onPressed: () => _addNewTransactionModal(context), child: const Icon(Icons.add)), floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat)
        : CupertinoPageScaffold(navigationBar: iosAppBar, child: body);
  }
}
