import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  final Function addNewTransaction;
  TransactionForm(this.addNewTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final inputController = TextEditingController();

  final amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void sumbitData() {
    if (_formKey.currentState.validate()) {
      final enteredName = inputController.text;
      final enteredAmount = double.parse(amountController.text);
      widget.addNewTransaction(
        enteredName,
        enteredAmount,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
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
                    onSaved: (_) => sumbitData,
                    controller: inputController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name is required!";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onSaved: (_) => sumbitData,
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                    ),
                    validator: (val) {
                      if ((double.tryParse(amountController.text) != null) ==
                          false) {
                        return "Invalid Number Format!";
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
              ),
              onPressed: sumbitData,
            )
          ],
        ),
      ),
    );
  }
}
