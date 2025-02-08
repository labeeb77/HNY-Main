import 'package:flutter/material.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/auth/sign_in_screen.dart';
import 'package:hny_main/view/screens/main/home/home_screen.dart';
import 'package:hny_main/view/screens/main/profile/add_driving_license_screen.dart';
import 'package:hny_main/view/screens/main/profile/add_id_card_screen.dart';
import 'package:hny_main/view/screens/main/profile/add_profile_screen.dart';
import 'package:hny_main/view/screens/main/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/login';
  static const String addProfile = '/addProfile';
  static const String homePage = '/home';
  static const String bottomNav = '/bottomNav';
  static const String idCardPage = '/idCardPage';
  static const String licensePage = '/licensePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments;
    }
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginPage:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case addProfile:
        return MaterialPageRoute(builder: (_) => const AddProfileScreen());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      case idCardPage:
        return MaterialPageRoute(builder: (_) => const EditIdScreen());
      case licensePage:
        return MaterialPageRoute(builder: (_) => const AddDrivingLicenseScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
