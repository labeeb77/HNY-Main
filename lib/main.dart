import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_theme.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavController(),),
        ChangeNotifierProvider(create: (context) => HomeController(),)
      ],
      child: MaterialApp(
        
          title: 'HNY-Customer',
        theme: AppTheme.lightTheme, // Apply the light theme
        darkTheme: AppTheme.darkTheme, // Optional: Apply the dark theme
        themeMode: ThemeMode.light, // Switches based on system preference
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

