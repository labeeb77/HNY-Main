import 'package:flutter/material.dart';

class PaymentOptionContainer extends StatelessWidget {
  const PaymentOptionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:  [
          BoxShadow(blurRadius: 4, spreadRadius: 1, color: Colors.grey.withOpacity(0.3))
        ],
        color: Colors.white,
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: PaymentOptions(
              title: 'Pay Full Amount',
             value:true
            ),
          ),
          Divider(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: PaymentOptions(
              title: 'Pay Custom Amount',
             value:false
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  final String title;
  final bool value;

  const PaymentOptions({
    super.key,
    required this.title,
    required this.value,
   
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(value: true, groupValue: true, onChanged: (value) {}),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
