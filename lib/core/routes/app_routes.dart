import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String loginPage = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String registration = '/register';
  static const String screenOtp = '/otp';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args;
    if (settings.arguments != null) {
      args = settings.arguments;
    }
    switch (settings.name) {
      case splashScreen:
      //   return MaterialPageRoute(builder: (_) => const ScreenSplash());
      // case loginPage:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case forgotPassword:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      // case screenOtp:
      //   return MaterialPageRoute(builder: (_) => ScreenOtp(args: args));



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
