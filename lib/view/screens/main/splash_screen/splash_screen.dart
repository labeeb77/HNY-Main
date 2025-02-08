import 'package:flutter/material.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();  
    // Fade in animation
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Check auth status after animation
    Future.delayed(const Duration(seconds: 2), () {
      checkAuthAndNavigate();
    });
  }

  Future<void> checkAuthAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (!mounted) return;

    if (accessToken != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.bottomNav);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    }
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
