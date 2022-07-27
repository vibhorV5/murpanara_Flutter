import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

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

  static dynamic customDialogBox({
    required BuildContext context,
    required MediaQueryData mediaQuery,
    required String headingText,
    required String subText,
    required String confirmText,
    required String cancelText,
    required void Function()? confirmFunction,
  }) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsets.all(10),
      content: Container(
        alignment: Alignment.topCenter,
        // color: Colors.pink,
        height: mediaQuery.size.height * 0.23,
        width: mediaQuery.size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                headingText,
                style: kBold.copyWith(fontSize: 20),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              child: Image.asset(
                'assets/images/mpr_eye.png',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              subText,
              style: kSemibold,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      cancelText,
                      style: kRegular.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: confirmFunction,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      confirmText,
                      style: kRegular.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
