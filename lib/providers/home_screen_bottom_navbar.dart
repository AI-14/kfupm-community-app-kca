import 'package:flutter/material.dart';

class HomeScreenBottomNavbarProvider extends ChangeNotifier {
  int index;

  HomeScreenBottomNavbarProvider({this.index = 0});

  void setIndex(int currentIndex) {
    index = currentIndex;
    notifyListeners();
  }
}
