import 'package:flutter/material.dart';
import 'package:hny_main/view/screens/main/bookings/bookings_screen.dart';
import 'package:hny_main/view/screens/main/favorite/favorite_screen.dart';
import 'package:hny_main/view/screens/main/home/home_screen.dart';
import 'package:hny_main/view/screens/main/profile/profile_screen.dart';

class BottomNavController extends ChangeNotifier {
  int currentScreenIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const BookingScreen(),
    const FavoriteScreen(),
    const ProfileScreen()
  ];

  changeScreenIndex(index, [isUpdate = true]) {
    currentScreenIndex = index;
    if (isUpdate) {
      notifyListeners();
    }
  }
}
