import 'package:flutter/material.dart';

class SelectedIndexProvider extends ChangeNotifier {
  int getSelectedIndex = 0;

  int get getCurrentSelectedIndex => getSelectedIndex;

  void setSlectedIndex(int selectedIndex) {
    getSelectedIndex = selectedIndex;
    notifyListeners();
    print('hello = ${getSelectedIndex}');
  }
}
