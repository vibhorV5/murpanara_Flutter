import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SizeProvider extends ChangeNotifier {
  String sizeSelected = 'S';

  String get getSizeSelected => sizeSelected;

  void setSize(String size) {
    sizeSelected = size;
    notifyListeners();
  }
}
