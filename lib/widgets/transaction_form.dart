import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatelessWidget {
  final inputController = TextEditingController();
  final amountController = TextEditingController();
  final Function addNewTransaction;
  TransactionForm(this.addNewTransaction);
  final _formKey = GlobalKey<FormState>();
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
              textColor: Colors.purple,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addNewTransaction(
                    inputController.text,
                    double.parse(amountController.text),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
