import 'package:flutter/foundation.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:uuid/uuid.dart';

class CheckoutDetailsProvider extends ChangeNotifier {
  ModeOfPayment? _selectedModeOfPayment = ModeOfPayment.razorPay;

  var uuid = const Uuid();

  String get userEmailID {
    var user = AuthService().currentUser!;
    return user.email!;
  }

  num totalSum(num sum) {
    return sum;
  }

  List<dynamic> getDescription(List<ShoppingCartProduct> shoppingCartProducts) {
    List<dynamic> newList = [];
    for (var i in shoppingCartProducts) {
      newList.add(i.productId);
      newList.add(i.size);
      newList.add(i.price);
      newList.add(i.quantity);
    }
    return newList;
  }

  String generateOrderId() {
    var generatedOrderId = uuid.v4();
    return generatedOrderId;
  }

  void modeOfPaymentValue(ModeOfPayment value) {
    _selectedModeOfPayment = value;
    notifyListeners();
  }

  ModeOfPayment get currentSelectedModeOfPayment => _selectedModeOfPayment!;

  DateTime currentOrderTime() {
    DateTime orderTime = DateTime.now();
    return orderTime;
  }
}
