import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function addNewTransaction;
  final Transaction transaction;
  TransactionForm({this.addNewTransaction, this.transaction});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _inputController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _date;
  final _formKey = GlobalKey<FormState>();

  void _sumbitData() {
    if (_formKey.currentState.validate()) {
      final enteredName = _inputController.text;
      final enteredAmount = double.parse(_amountController.text);
      widget.addNewTransaction(
        enteredName,
        enteredAmount,
        _date,
      );
      Navigator.of(context).pop();
    }
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      _date = value;
      _dateController.text = DateFormat.yMMMd().format(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    onSaved: (_) => _sumbitData,
                    controller: widget.transaction != null
                        ? (_inputController..text = widget.transaction.title)
                        : _inputController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name is required!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onSaved: (_) => _sumbitData,
                    keyboardType: TextInputType.number,
                    controller: widget.transaction != null
                        ? (_amountController
                          ..text = widget.transaction.amount.toString())
                        : _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    validator: (val) {
                      if ((double.tryParse(_amountController.text) != null) ==
                          false) {
                        return "Invalid Number Format!";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: widget.transaction != null
                                ? (_dateController
                                  ..text = DateFormat.yMMMd()
                                      .format(widget.transaction.date))
                                : _dateController,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              errorStyle: TextStyle(
                                color: Theme.of(context).errorColor,
                              ),
                              labelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Date is required!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Flexible(
                          child: FlatButton(
                            child: Text(
                              'Choose date',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _openDatePicker,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              onPressed: _sumbitData,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
