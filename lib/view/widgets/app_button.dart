import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class PrimaryElevateButton extends StatelessWidget {
  final String? buttonName;
  final bool isGrey;
  final VoidCallback? ontap;
  final bool loading; // Add this line

  const PrimaryElevateButton({
    this.ontap,
    this.buttonName,
    this.isGrey = false,
    this.loading = false, // Add this line
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed:
            loading ? null : ontap ?? () {}, // Disable button when loading
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: loading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white), // Customize loader color
                ),
              )
            : FittedBox(
                child: AppText(
                  buttonName ?? "Book Now",
                  color: isGrey ? AppColors.primary : AppColors.white,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                ),
              ),
      ),
    );
  }
}

class LoadingTextButton extends StatelessWidget {
  final String? buttonName;
  final bool isGrey;
  final VoidCallback? onTap;
  final bool loading; // Controls the loading state

  const LoadingTextButton({
    this.onTap,
    this.buttonName,
    this.isGrey = false,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        onPressed: loading ? null : onTap ?? () {}, // Disable button when loading
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: isGrey ? AppColors.grey : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading) // Show loader if loading is true
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            if (loading) const SizedBox(width: 8), // Add spacing between loader and text
            FittedBox(
              child: AppText(
                buttonName ?? "Book Now",
                color: isGrey ? AppColors.primary : AppColors.white,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// secondary button

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.borderRadius = 25.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ??
              theme.colorScheme.primary, // Default to theme primary color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
