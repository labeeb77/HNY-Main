import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomViewModel = Provider.of<BottomNavController>(context);
    final screenSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Consumer<BottomNavController>(
        builder: (context, value, child) => value.screens[value.currentScreenIndex],
      ),
      bottomNavigationBar: OrientationBuilder(
        builder: (context, orientation) {
          // Calculate dynamic height based on screen size and orientation
          final double navBarHeight = (orientation == Orientation.portrait)
              ? math.max(screenSize.height * 0.08, 56.0) // Minimum height of 56
              : math.max(screenSize.width * 0.06, 48.0); // Minimum height of 48 for landscape

          return SafeArea(
            maintainBottomViewPadding: true,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: math.min(28, screenSize.width * 0.05), // Responsive padding
                vertical: 4, // Add some vertical padding
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
              width: double.infinity,
              height: navBarHeight + bottomPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: NavItemWidget(
                      isSelected: bottomViewModel.currentScreenIndex == 0,
                      label: "Home",
                      icon: Icons.home_outlined,
                      ontap: () => bottomViewModel.changeScreenIndex(0),
                      orientation: orientation,
                    ),
                  ),
                  Expanded(
                    child: NavItemWidget(
                      isSelected: bottomViewModel.currentScreenIndex == 1,
                      label: "Bookings",
                      icon: Icons.confirmation_number_outlined,
                      ontap: () => bottomViewModel.changeScreenIndex(1),
                      orientation: orientation,
                    ),
                  ),
                  Expanded(
                    child: NavItemWidget(
                      isSelected: bottomViewModel.currentScreenIndex == 2,
                      label: "Favorites",
                      icon: Icons.favorite_outline,
                      ontap: () => bottomViewModel.changeScreenIndex(2),
                      orientation: orientation,
                    ),
                  ),
                  Expanded(
                    child: NavItemWidget(
                      isSelected: bottomViewModel.currentScreenIndex == 3,
                      label: "Profile",
                      icon: Icons.person_outline,
                      ontap: () => bottomViewModel.changeScreenIndex(3),
                      orientation: orientation,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
