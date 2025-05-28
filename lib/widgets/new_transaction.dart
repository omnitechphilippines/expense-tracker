import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount, DateTime date) newTransaction;

  const NewTransaction({super.key, required this.newTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      widget.newTransaction(_titleController.text, double.parse(_amountController.text), _selectedDate);
      Navigator.pop(context);
    }
  }

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final DateTime lastDate = DateTime(now.year + 1, now.month, now.day);
    final DateTime? pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);
    if (pickedDate != null) setState(() => _selectedDate = pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(onSubmitted: (_) => _submitData, controller: _titleController, decoration: const InputDecoration(labelText: 'Title'), style: TextStyle(color: isDarkMode ? kColorScheme.onPrimary : const Color(0xFF1F1A1F))),
            TextField(
              onSubmitted: (_) => _submitData,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              style: TextStyle(color: isDarkMode ? kColorScheme.onPrimary : const Color(0xFF1F1A1F)),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(DateFormat.yMd().format(_selectedDate), style: TextStyle(color: isDarkMode ? kColorScheme.onPrimary : const Color(0xFF1F1A1F))),
                  const Spacer(),
                  kIsWeb || Platform.isAndroid || Platform.isWindows
                      ? TextButton(onPressed: _presentDatePicker, child: const Text('Choose date', style: TextStyle(fontWeight: FontWeight.bold)))
                      : CupertinoButton(onPressed: _presentDatePicker, child: const Text('Choose date', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            ElevatedButton(onPressed: _submitData, style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor), child: Text('Add Transaction', style: TextStyle(color: kColorScheme.primaryContainer))),
          ],
        ),
      ),
    );
  }
}
