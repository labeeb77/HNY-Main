import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((va) {
      Provider.of<HomeController>(context, listen: false)
          .getCarDataList(context);
      Provider.of<ProfileProvider>(context, listen: false)
          .getUserProfileDetails(context);
    });
    super.initState();
  }

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
        builder: (context, orientation) => SafeArea(
          maintainBottomViewPadding: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
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
            height: (orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 13
                : MediaQuery.of(context).size.width / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavItemWidget(
                  isSelected: bottomViewModel.currentScreenIndex == 0,
                  label: "Home",
                  icon: Icons.home_outlined,
                  ontap: () {
                    log(orientation.name);
                    bottomViewModel.changeScreenIndex(0);
                  },
                  orientation: orientation,
                ),
                NavItemWidget(
                  isSelected: bottomViewModel.currentScreenIndex == 1,
                  label: "Bookings",
                  icon: Icons.confirmation_number_outlined,
                  ontap: () {
                    bottomViewModel.changeScreenIndex(1);
                  },
                  orientation: orientation,
                ),
                NavItemWidget(
                  isSelected: bottomViewModel.currentScreenIndex == 2,
                  label: "Favorites",
                  icon: Icons.favorite_outline,
                  ontap: () {
                    bottomViewModel.changeScreenIndex(2);
                  },
                  orientation: orientation,
                ),
                NavItemWidget(
                  isSelected: bottomViewModel.currentScreenIndex == 3,
                  label: "Profile",
                  icon: Icons.person_outline,
                  ontap: () {
                    bottomViewModel.changeScreenIndex(3);
                  },
                  orientation: orientation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
