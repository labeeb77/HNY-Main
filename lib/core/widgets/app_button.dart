import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.color,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: child,
    );
  }
}