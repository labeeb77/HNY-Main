import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hny_main/core/utils/app_colors.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppAlerts {
  static appToast(String message, {Color color = Colors.black}) {
    if (message.isNotEmpty) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: color,

        textColor: AppColors.white,
        fontSize: 16.0,
        webBgColor: "linear-gradient(to right, #000000, #000000)",
        // For web
        webPosition: "center",
      );
    }
  }

  static void showCustomSnackBar(String message, {bool isSuccess = true}) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isSuccess ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        isSuccess ? Icons.check_circle : Icons.error,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: AppColors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Dismiss'),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
    ));
  }

  static appContentToast(BuildContext context, Widget content, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        content: content));
  }
}

TextStyle getStyle(Color color) {
  if (color == Colors.red ||
      color == Colors.green ||
      color == Colors.blueGrey[900]) {
    return const TextStyle(
      color: AppColors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  } else if (color == Colors.yellow) {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  } else {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }
}
