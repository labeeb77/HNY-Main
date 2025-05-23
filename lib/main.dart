import 'package:flutter/material.dart';
import 'package:hny_main/core/helpers/provider_setup.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_theme.dart';
import 'package:hny_main/view/screens/Search/search.dart';
import 'package:hny_main/view/screens/main/onboarding/onboarding_screen.dart';
import 'package:hny_main/view/screens/main/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderSetup.getProviders(),
      child: MaterialApp(
        title: 'HNY CUSTOMER',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRoutes.generateRoute,
        supportedLocales: [
          const Locale('en', 'GB'), // British English for dd/MM/yyyy
        ],
          localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
        locale: const Locale('en', 'GB'), // force it to use dd/MM/yyyy
        home: const SplashScreen(),
      ),
    );
  }
}
