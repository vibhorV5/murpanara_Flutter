import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier {
  int quantitySelected = 1;

  int get getQuantity => quantitySelected;

  void decreaseQuantity() {
    if (quantitySelected <= 1) {
      return;
    }
    quantitySelected = quantitySelected - 1;
    notifyListeners();
  }

  void increaseQuantity() {
    if (quantitySelected >= 10) {
      return;
    }
    quantitySelected = quantitySelected + 1;
    notifyListeners();
  }

  void setQuantity(int quantity) {
    quantitySelected = quantity;
    notifyListeners();
  }
}
