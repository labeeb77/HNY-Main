import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_button.dart';

class BookingPrice extends StatelessWidget {
  final title;
  final value;
  final buttonName;
  final onTap;
  const BookingPrice(
      {super.key, this.title, this.value, this.buttonName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(color: AppColors.containerBorderColor))),
      padding: const EdgeInsets.only(bottom: 24, left: 19, right: 19, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'AED $value',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          PrimaryElevateButton(ontap: onTap, buttonName: buttonName)
        ],
      ),
    );
  }
}
