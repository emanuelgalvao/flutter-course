import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Theme.of(context).primaryColor,
    titleTextStyle: const TextStyle(
      fontSize: 20,
    ),
    foregroundColor: Colors.white,
  );
}
