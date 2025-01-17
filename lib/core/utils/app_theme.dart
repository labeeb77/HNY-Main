import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      color: AppColors.primary,
      foregroundColor: AppColors.primary,
      systemOverlayStyle:
          SystemUiOverlayStyle.dark // or use SystemUiOverlayStyle.light
      ,
      titleTextStyle: AppTextStyles.bodyText1.copyWith(color: Colors.white),
    ),

    // textTheme: const TextTheme(
    //   headline1: AppTextStyles.headline1,
    //   bodyText1: AppTextStyles.bodyText1,
    //   caption: AppTextStyles.caption,
    // ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
  );
}
