import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/transaction_form.dart';
import 'package:personal_expense_app/widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/transaction_form.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
        ),
      ),
      home: MyHomePage(title: 'Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Internet Bill',
    //   amount: 1899,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Electric Bill',
    //   amount: 2500,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(String name, double amount, DateTime date) {
    final newTx = Transaction(
        title: name,
        amount: amount,
        date: date,
        id: 'tx${_userTransactions.length + 1}');

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(Transaction tx) {
    setState(() {
      _userTransactions.remove(tx);
    });
  }

  void _startNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: TransactionForm(
                addNewTransaction: _addNewTransaction,
              ),
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTx {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).appBarTheme.textTheme.subtitle1,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTx(
            context,
          ),
        )
      ],
    );

    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      _appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  (_isLandScape ? 0.5 : 0.3),
              child: Chart(_recentTx),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      _appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  (_isLandScape ? 0.5 : 0.7),
              child: TransactionList(
                _userTransactions,
                _addNewTransaction,
                _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTx(
          context,
        ),
      ),
    );
  }
}
