import 'package:flutter/material.dart';

class DialogService {
  static _close(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<void> message(
    BuildContext context, {
    String? title,
    required String content,
    void Function()? onAccept,
    String? acceptLabel,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onAccept ?? () => DialogService._close(context),
              child: Text(acceptLabel ?? 'Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
