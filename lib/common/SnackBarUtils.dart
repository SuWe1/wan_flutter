import 'package:flutter/material.dart';

const Duration _shortShow = Duration(milliseconds: 1000);
const Duration _longShow = Duration(milliseconds: 4000);

class SnackBarUtils {
  static void show(BuildContext context, String str,
      {Duration duration = _shortShow, SnackBarAction action}) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(str == null ? '' : str),
      duration: duration,
      action: action,
    ));
  }
}
