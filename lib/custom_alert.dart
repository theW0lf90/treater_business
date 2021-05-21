import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String message;
  final String title;
  const CustomAlert({
    Key key, this.message, this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: new Text(title, style: Theme.of(context).textTheme.headline1),
      content: new Text(message, style: Theme.of(context).textTheme.bodyText1),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Luk"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}