import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

void showSuccessAnimation(BuildContext context) {
  // Declare the overlay variable first
  late OverlayEntry overlay;
  
  // Define the overlay entry
  overlay = OverlayEntry(
    builder: (context) => Positioned(
      top: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Added to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            onEnd: () {
              // Keep the animation visible for 1.5 seconds before dismissing
              Future.delayed(const Duration(milliseconds: 1500), () {
                overlay.remove();
              });
            },
          ),
        ),
      ),
    ),
  );

  // Show the overlay
  Overlay.of(context).insert(overlay);
}
