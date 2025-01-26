import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
  required IconData icon,
}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
  );

  return snackBar;
}
