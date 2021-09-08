import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transction added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            transactions[index].amount.toString(),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title as String,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMM().format(transactions[index].date!),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
                /*return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transactions[index].amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(transactions[index].title.toString(),
                              style: Theme.of(context).textTheme.headline6),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              DateFormat.yMMM()
                                  .format(transactions[index].date!),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );*/
              },
              itemCount: transactions.length,
            ),
    );
  }
}
