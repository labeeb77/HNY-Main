import 'package:flutter/material.dart';
import 'package:hny_main/view/screens/main/bookings/bookings_screen.dart';
import 'package:hny_main/view/screens/main/home/home_screen.dart';

class BottomNavController extends ChangeNotifier {
  int currentScreenIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    BookingsScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  changeScreenIndex(index) {
    currentScreenIndex = index;
    notifyListeners();
  }
}
