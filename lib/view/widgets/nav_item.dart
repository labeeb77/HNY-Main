
import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class NavItemWidget extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback ontap;
  final orientation;

  const NavItemWidget({
    required this.isSelected,
    required this.icon,
    required this.ontap,
    required this.label,
    required this.orientation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Fixed height for the indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isSelected ? MediaQuery.of(context).size.width / 10 : 0,
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),

            const SizedBox(height: 8),
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            orientation == Orientation.portrait
                ? Column(
                    children: [
                      const SizedBox(height: 4),
                      AppText(
                        label,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}