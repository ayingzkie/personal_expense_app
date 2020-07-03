import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/transaction_form.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransactions;
  final Function newTx;
  final Function removeTx;
  TransactionList(this.userTransactions, this.newTx, this.removeTx);
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _editTx(BuildContext ctx, Transaction tx) {
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
    final _isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return widget.userTransactions.isEmpty
        ? Column(
            children: [
              FittedBox(
                child: Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height *
                    (_isLandScape ? 0.2 : 0.5),
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
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
                    _editTx(ctx, widget.userTransactions[index]);
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
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      widget.removeTx(widget.userTransactions[index]);
                    },
                  ),
                ),
              );
            },
            itemCount: widget.userTransactions.length,
          );
  }
}
