import './widgets/chart.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Manager",
      home: MyHomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            // ignore: deprecated_member_use
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final List<Transaction> transactions = [
    /*Transaction(
      id: 't1',
      title: 'Buy a lambo',
      amount: 12.34,
      date: DateTime.now(),
    ),
    Transaction(
        id: 't2',
        title: 'Buy 4runner 2010',
        amount: 20.55,
        date: DateTime.now()),*/
  ];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      transactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Chart(
                  transactions,
                ),
                color: Theme.of(context).primaryColor,
                elevation: 5,
              ),
            ),
            TransactionList(transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
