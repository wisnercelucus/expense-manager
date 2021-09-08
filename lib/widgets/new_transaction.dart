import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmitData() {
    final String title = titleController.text;

    if (title == '' || amountController.text == '') {
      return;
    }

    final double amount = double.parse(amountController.text);
    widget.addTransaction(
      title,
      amount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => onSubmitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: Text("Add transaction"),
              onPressed: onSubmitData,
            )
          ],
        ),
      ),
    );
  }
}
