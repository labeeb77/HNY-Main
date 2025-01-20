
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class RadioBoxElement extends StatelessWidget {
  final padding;
  final status;
  final title;
  const RadioBoxElement({
    required this.title,
    required this.padding,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Radio(value: status, groupValue: status, onChanged: (value) {}),
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