import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/view/widgets/nav_item.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Provider.of<BottomNavController>(context);

    return Scaffold(
      body: Consumer<BottomNavController>(
          builder: (context, value, child) =>
              value.screens[value.currentScreenIndex]),
      bottomNavigationBar: OrientationBuilder(
        builder: (context, orientation) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
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
              ? MediaQuery.of(context).size.height / 11
              : MediaQuery.of(context).size.width / 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavItemWidget(
                isSelected: bottomNavController.currentScreenIndex == 0,
                label: "Home",
                icon: Icons.home_outlined,
                ontap: () {
                  log(orientation.name);
                  bottomNavController.changeScreenIndex(0);
                },
                orientation: orientation,
              ),
              NavItemWidget(
                isSelected: bottomNavController.currentScreenIndex == 1,
                label: "Task",
                icon: Icons.task_outlined,
                ontap: () {
                  bottomNavController.changeScreenIndex(1);
                },
                orientation: orientation,
              ),
              NavItemWidget(
                isSelected: bottomNavController.currentScreenIndex == 2,
                label: "Profile",
                icon: Icons.person_outline,
                ontap: () {
                  bottomNavController.changeScreenIndex(2);
                },
                orientation: orientation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
