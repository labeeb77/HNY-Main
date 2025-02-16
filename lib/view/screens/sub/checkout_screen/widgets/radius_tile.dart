
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class RadioBoxElement extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool status;
  final String title;
  final void Function(bool?)? onChanged;

  const RadioBoxElement({
    required this.title,
    required this.padding,
    required this.status,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: status,
            onChanged: onChanged,
            activeColor: AppColors.primary, // Add your app's primary color
          ),
          const Gap(16),
          AppText(
            title,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}