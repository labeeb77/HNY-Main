
import 'package:flutter/material.dart';
import 'package:hny_main/view/screens/home/home.dart';

class BottomNavController extends ChangeNotifier {
  int currentScreenIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
  
  ];

  changeScreenIndex(index) {
    currentScreenIndex = index;
    notifyListeners();
  }
}
