import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/common/bottom_nav.dart';

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

    // Fade in
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Fade out after 1 second and navigate
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });

      // Navigate to the next screen after the animation
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNav(),), (route) => true,); // Replace with your actual screen
      });
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
            child: Image.asset("assets/logo/Removebg preview 1.png"),
          ),
        ),
      ),
    );
  }
}
