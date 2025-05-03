import 'package:flutter/material.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/auth/sign_in_screen.dart';
import 'package:hny_main/view/screens/main/cart/my_cart_screen.dart';
import 'package:hny_main/view/screens/main/home/home_screen.dart';
import 'package:hny_main/view/screens/main/onboarding/onboarding_screen.dart';
import 'package:hny_main/view/screens/main/profile/manage_license.dart';
import 'package:hny_main/view/screens/main/profile/manage_gcc_id.dart';
import 'package:hny_main/view/screens/main/profile/manage_passport.dart';
import 'package:hny_main/view/screens/main/profile/manage_profile_screen.dart';
import 'package:hny_main/view/screens/main/splash_screen/splash_screen.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/checkout_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/login';
  static const String manageProfile = '/manageProfile';
  static const String homePage = '/home';
  static const String bottomNav = '/bottomNav';
  static const String manageGccId = '/manageGccId';
  static const String manageLicense = '/manageLicense';
  static const String managePassport = '/managePassport';
  static const String onboardingScreen = '/onboardingScreen';

  static const String myCartPage = '/myCartPage';

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
      case manageProfile:
        return MaterialPageRoute(
            builder: (_) => ManageProfileScreen(
                  screenName: args,
                ));
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case bottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNav());
      case manageGccId:
        final data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ManageGCCId(
                  from: data,
                ));
      case manageLicense:
        final data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ManageDrivingLicense(
                  from: data,
                ));
      case managePassport:
        final data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ManagePassport(
                  from: data,
                ));
        case myCartPage:
          return MaterialPageRoute(builder: (_) => const MyCartScreen());
      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
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
