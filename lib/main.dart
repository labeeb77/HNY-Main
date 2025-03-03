import 'package:flutter/material.dart';
import 'package:hny_main/core/helpers/provider_setup.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_theme.dart';
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
      providers: ProviderSetup.getProviders(),
      child: MaterialApp(
        title: 'HNY-Customer',
        theme: AppTheme.lightTheme, // Apply the light theme
        darkTheme: AppTheme.darkTheme, // Optional: Apply the dark theme
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRoutes.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
