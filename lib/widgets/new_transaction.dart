import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime? datePicked;

  bool _isNull({datePicked: DateTime}) {
    return datePicked == null;
  }

  void _launchDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        datePicked = value;
      });
    });
  }

  void _onSubmitData() {
    final String title = titleController.text;

    if (title == '' || amountController.text == '') {
      return;
    }

    if (_isNull(datePicked: datePicked)) {
      return;
    }

    final double amount = double.parse(amountController.text);
    widget.addTransaction(
      title,
      amount,
      datePicked,
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
              onSubmitted: (_) => _onSubmitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _onSubmitData(),
            ),
            Row(
              children: <Widget>[
                Text(!_isNull(datePicked: datePicked)
                    ? DateFormat.yMd().format(datePicked!)
                    : "No date chosen"),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  onPressed: _launchDatePicker,
                  child: Text("Chose a date"),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                onPrimary: Theme.of(context).textTheme.button!.color,
              ),
              child: Text("Add transaction"),
              onPressed: _onSubmitData,
            )
          ],
        ),
      ),
    );
  }
}
