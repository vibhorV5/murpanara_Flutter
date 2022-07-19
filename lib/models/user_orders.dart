import 'package:murpanara/models/shoppingcartproduct.dart';

class UserOrders {
  final String firstName;
  final String lastName;
  final num? phone;
  final String emailId;
  final String deliveryAddress;
  final num? amountPaid;
  final String orderStatus;
  final String modeOfPayment;
  final List<String> orderedProducts;
  final String orderTime;
  final String orderId;

  UserOrders({
    this.amountPaid = 0,
    this.deliveryAddress = '',
    this.emailId = '',
    this.firstName = '',
    this.lastName = '',
    this.modeOfPayment = '',
    this.orderStatus = '',
    this.phone = 0,
    this.orderedProducts = const [],
    this.orderTime = '',
    this.orderId = '',
  });
}
