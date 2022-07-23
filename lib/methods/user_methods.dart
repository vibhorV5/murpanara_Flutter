import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMethods {
  static String checkNumField(num digit) {
    if (digit == 0) {
      return '';
    } else {
      return digit.toString();
    }
  }

  static String checkUserName(String name) {
    if (name == '') {
      return 'Member';
    } else {
      return name;
    }
  }

  static String getCurrentDateTime(DateTime orderTime) {
    return orderTime.toString();
  }

  static String getModeOfPayment(String modeOfPayment) {
    if (modeOfPayment == 'ModeOfPayment.cashOnDelivery') {
      return 'Cash on Delivery';
    } else if (modeOfPayment == 'ModeOfPayment.razorPay') {
      return 'RazorPay';
    } else {
      return modeOfPayment;
    }
  }

  static Color getColorBasedOnOrderStatus(String orderStatus) {
    if (orderStatus == 'Processing') {
      return Colors.blue;
    } else if (orderStatus == 'Delivered') {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }
}
