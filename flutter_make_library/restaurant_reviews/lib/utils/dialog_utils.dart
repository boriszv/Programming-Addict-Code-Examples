import 'package:flutter/material.dart';

Future showOkDialog(BuildContext context, { String title, String content }) {
  return showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [TextButton(onPressed: () {
      Navigator.of(context).pop();

    }, child: Text('Ok'))],
  ));
}
