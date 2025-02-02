import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class GlobalSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = true,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor:isError?Colors.red:Colors.green,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
