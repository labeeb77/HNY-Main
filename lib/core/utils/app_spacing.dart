import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class AppSpacingWidgets {
  // spacer
  static const Spacer spacer = Spacer();

  static const SizedBox sb = SizedBox();

  //height
  static const SizedBox sbh2 = SizedBox(height: 2);
  static const SizedBox sbh3 = SizedBox(height: 3);
  static const SizedBox sbh5 = SizedBox(height: 5);
  static const SizedBox sbh8 = SizedBox(height: 8);
  static const SizedBox sbh10 = SizedBox(height: 10);
  static const SizedBox sbh15 = SizedBox(height: 15);
  static const SizedBox sbh16 = SizedBox(height: 16);
  static const SizedBox sbh20 = SizedBox(height: 20);
  static const SizedBox sbh25 = SizedBox(height: 25);
  static const SizedBox sbh30 = SizedBox(height: 30);
  static const SizedBox sbh40 = SizedBox(height: 40);
  static const SizedBox sbh45 = SizedBox(height: 45);
  static const SizedBox sbh50 = SizedBox(height: 50);
  static const SizedBox sbh80 = SizedBox(height: 80);
  static const SizedBox sbh100 = SizedBox(height: 100);
  static const SizedBox sbh130 = SizedBox(height: 130);
  static const SizedBox sbh150 = SizedBox(height: 150);
  static const SizedBox sbh180 = SizedBox(height: 180);

  //width
  static const SizedBox sbw5 = SizedBox(width: 5);
  static const SizedBox sbw8 = SizedBox(width: 8);
  static const SizedBox sbw10 = SizedBox(width: 10);
  static const SizedBox sbw15 = SizedBox(width: 15);
  static const SizedBox sbw16 = SizedBox(width: 16);
  static const SizedBox sbw2 = SizedBox(width: 2);
  static const SizedBox sbw3 = SizedBox(width: 3);
  static const SizedBox sbw20 = SizedBox(width: 20);
  static const SizedBox sbw25 = SizedBox(width: 25);
  static const SizedBox sbw30 = SizedBox(width: 30);
  static const SizedBox sbw40 = SizedBox(width: 40);
  static const SizedBox sbw48 = SizedBox(width: 48);
  static const SizedBox sbw120 = SizedBox(width: 120);
  static const SizedBox sbw80 = SizedBox(width: 80);
  static const Divider divider = Divider(color: AppColors.grey, height: 1);

  static void globalUnfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
