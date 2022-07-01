// @dart=2.9
import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT, CLOSE }

Future<ConfirmAction> customConfirmDialog(
    BuildContext context, String titleText, String contentText) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('ACCEPT'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          ),
          ElevatedButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
        ],
      );
    },
  );
}

Future<ConfirmAction> showMessageDialog(
    BuildContext context, String titleText, String contentText) {
  return showDialog<ConfirmAction>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('ตกลง'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CLOSE);
            },
          ),
        ],
      );
    },
  );
}
