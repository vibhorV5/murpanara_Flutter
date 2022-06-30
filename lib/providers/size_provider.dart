import 'package:flutter/material.dart';

class SizeProvider extends ChangeNotifier {
  String sizeSelected = '';

  String get getSizeSelected => sizeSelected;

  void setSize(String size) {
    sizeSelected = size;
    notifyListeners();
  }
}
