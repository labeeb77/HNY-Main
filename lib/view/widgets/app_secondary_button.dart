import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.green.shade900, // Text color
        backgroundColor: Colors.green.shade50, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        elevation: 0, // Remove shadow
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
