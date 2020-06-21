import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/models/transaction.dart';
import 'package:personal_expense_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTx;

  Chart(this.recentTx);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTx.length; i++) {
        if (recentTx[i].date.day == weekDay.day &&
            recentTx[i].date.month == weekDay.month &&
            recentTx[i].date.year == weekDay.year) {
          totalSum += recentTx[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        // child: ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       width: 56,
        //       child: ChartBar(
        //         groupedTransactions[index]['day'],
        //         groupedTransactions[index]['amount'],
        //         totalSpending != 0
        //             ? (groupedTransactions[index]['amount'] as double) /
        //                 totalSpending
        //             : 0.0,
        //       ),
        //     );
        //   },
        //   itemCount: groupedTransactions.length,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ChartBar(
                    e['day'],
                    e['amount'],
                    totalSpending != 0
                        ? (e['amount'] as double) / totalSpending
                        : 0.0,
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}
