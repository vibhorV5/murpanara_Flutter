import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/save_button.dart';

class OrderSuccessFailurePage extends StatelessWidget {
  const OrderSuccessFailurePage({
    Key? key,
    required this.greetingText,
    required this.orderStatusText,
    required this.onpressFunc,
    required this.statusText,
  }) : super(key: key);

  final String greetingText;
  final String orderStatusText;
  final void Function()? onpressFunc;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: _mediaQuery.size.height * 0.05,
                  horizontal: _mediaQuery.size.width * 0.03),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: _mediaQuery.size.width * 0.75,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: _mediaQuery.size.height * 0.3,
                    width: _mediaQuery.size.height * 0.3,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      size: _mediaQuery.size.height * 0.2,
                    ),
                  ),
                  Container(
                    height: _mediaQuery.size.height * 0.075,
                    width: _mediaQuery.size.height * 0.075,
                    alignment: Alignment.center,
                    // color: Colors.amber,
                    margin:
                        EdgeInsets.only(top: _mediaQuery.size.height * 0.055),
                    child: statusText == 'Success'
                        ? Icon(
                            Icons.done,
                            color: Colors.green,
                            size: _mediaQuery.size.height * 0.06,
                          )
                        : Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                            size: _mediaQuery.size.height * 0.06,
                          ),
                  ),
                ],
              ),
            ),
            Text(
              greetingText,
              style: kBold.copyWith(fontSize: _mediaQuery.size.width * 0.15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                  child: Text(
                    orderStatusText,
                    style: kBold.copyWith(
                        fontSize: _mediaQuery.size.height * 0.022),
                  ),
                ),
              ],
            ),
            HeadingsTitle(
                titleText: 'Return to Home Page',
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.09),
                fontSize: _mediaQuery.size.height * 0.02),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _mediaQuery.size.width * 0.1),
              child: SaveButton(
                fontSize: _mediaQuery.size.height * 0.02,
                height: _mediaQuery.size.height * 0.056,
                borderRadiusGeometry:
                    BorderRadius.circular(_mediaQuery.size.height * 0.04),
                mediaQuery: _mediaQuery,
                txt: 'Home Page',
                color: Colors.black87,
                txtColor: Colors.white,
                onPress: onpressFunc,
              ),
            )
          ],
        ),
      ),
    );
  }
}
