import 'package:flutter/material.dart';

AppBar customAppbar(
  BuildContext context,
  String title,
  List<Widget>? actions,
) {
  return AppBar(
    title: Text(title),
    backgroundColor: Theme.of(context).primaryColor,
    foregroundColor: Colors.white,
    actions: actions,
  );
}
