import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/transaction_form.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransactions;
  final Function newTx;
  TransactionList(this.userTransactions, this.newTx);
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _deleteTransaction(index) {
    setState(() {
      widget.userTransactions.removeAt(index);
    });
  }

  void _startNewTx(BuildContext ctx, Transaction tx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionForm(
              addNewTransaction: widget.newTx,
              transaction: tx,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: widget.userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    onTap: () {
                      _startNewTx(ctx, widget.userTransactions[index]);
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text('\$${widget.userTransactions[index].amount}'),
                    ),
                    title: Text(
                      widget.userTransactions[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.userTransactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTransaction(index);
                      },
                    ),
                  ),
                );
              },
              itemCount: widget.userTransactions.length,
            ),
    );
  }
}
