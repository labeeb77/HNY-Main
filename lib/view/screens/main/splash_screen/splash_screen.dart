import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/auth/sign_in_screen.dart';
import 'package:hny_main/view/screens/main/auth/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  // Function to check user token in SharedPreferences
  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      // Navigate to BottomNav if token exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    } else {
      // Navigate to SignUpScreen if no token found
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Fade in animation
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Wait for a short time to show splash, then check authentication status
    Future.delayed(const Duration(seconds: 2), () {
      checkAuth(); // Check token and navigate accordingly
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1), // Fade duration
          child: SizedBox(
            height: 148,
            child: Image.asset("assets/logo/splash_screen_logo.png"),
          ),
        ),
      ),
    );
  }
}
