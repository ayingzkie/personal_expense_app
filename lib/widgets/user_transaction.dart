import 'package:flutter/material.dart';
import '../widgets/transaction_form.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Internet Bill',
      amount: 1899,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Electric Bill',
      amount: 2500,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String name, double amount) {
    final newTx = Transaction(
        title: name,
        amount: amount,
        date: DateTime.now(),
        id: 'tx${_userTransactions.length + 1}');

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
