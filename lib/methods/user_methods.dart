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
    double borderRadius = 15,
    double contentPadding = 15,
    double contentContainerHeight = 180,
    double headingTextTopMargin = 10,
    double headingTextFontSize = 20,
    double mprEyeContainerHeight = 30,
    double mprEyeContainerWidth = 30,
    double bigSizedBoxHeight = 30,
    double smallSizedBoxHeight = 10,
    double textButtonHorizontalPadding = 20,
    double textButtonVerticalpadding = 10,
    double textButtonBorderRadius = 30,
  }) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      contentPadding: EdgeInsets.all(contentPadding),
      content: Container(
        alignment: Alignment.topCenter,
        height: contentContainerHeight,
        width: mediaQuery.size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: headingTextTopMargin),
              child: Text(
                headingText,
                style: kBold.copyWith(fontSize: headingTextFontSize),
              ),
            ),
            SizedBox(
              height: mprEyeContainerHeight,
              width: mprEyeContainerWidth,
              child: Image.asset(
                'assets/images/mpr_eye.png',
              ),
            ),
            SizedBox(
              height: bigSizedBoxHeight,
            ),
            Center(
              child: Text(
                subText,
                style: kSemibold,
              ),
            ),
            SizedBox(
              height: smallSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: textButtonHorizontalPadding,
                        vertical: textButtonVerticalpadding),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:
                          BorderRadius.circular(textButtonBorderRadius),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: textButtonHorizontalPadding,
                      vertical: textButtonVerticalpadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:
                          BorderRadius.circular(textButtonBorderRadius),
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
      },
    );
  }

  static dynamic customDialogBoxOneButton({
    required BuildContext context,
    required MediaQueryData mediaQuery,
    required String headingText,
    required String subText,
    required String confirmText,
    required String cancelText,
    required void Function()? confirmFunction,
    double borderRadius = 15,
    double contentPadding = 15,
    double contentContainerHeight = 180,
    double headingTextTopMargin = 10,
    double headingTextFontSize = 20,
    double mprEyeContainerHeight = 30,
    double mprEyeContainerWidth = 30,
    double bigSizedBoxHeight = 30,
    double smallSizedBoxHeight = 10,
    double textButtonHorizontalPadding = 20,
    double textButtonVerticalpadding = 10,
    double textButtonBorderRadius = 30,
  }) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      contentPadding: EdgeInsets.all(contentPadding),
      content: Container(
        alignment: Alignment.topCenter,
        // color: Colors.pink,
        height: contentContainerHeight,
        width: mediaQuery.size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: headingTextTopMargin),
              child: Text(
                headingText,
                style: kBold.copyWith(fontSize: headingTextFontSize),
              ),
            ),
            SizedBox(
              height: mprEyeContainerHeight,
              width: mprEyeContainerWidth,
              child: Image.asset(
                'assets/images/mpr_eye.png',
              ),
            ),
            SizedBox(
              height: bigSizedBoxHeight,
            ),
            Center(
              child: Text(
                subText,
                style: kSemibold,
              ),
            ),
            SizedBox(
              height: smallSizedBoxHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: confirmFunction,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: textButtonHorizontalPadding,
                      vertical: textButtonVerticalpadding,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:
                          BorderRadius.circular(textButtonBorderRadius),
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
      },
    );
  }
}
