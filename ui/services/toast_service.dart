import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:injectable/injectable.dart';

// @singleton
class ToastService {
  static final _toast = FToast();

  ToastService();

  static show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.blueGrey,
    Color textColor = Colors.white,
  }) {
    _toast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Text(message, style: TextStyle(color: textColor)),
    );

    _toast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(milliseconds: 2500),
    );
  }

  static catchError(BuildContext context, dynamic exception) {}
}
