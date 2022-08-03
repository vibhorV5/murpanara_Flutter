import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/widgets/save_button.dart';

class OrderSuccessFailurePage extends StatelessWidget {
  const OrderSuccessFailurePage(
      {Key? key,
      required this.greetingText,
      required this.orderStatusText,
      required this.statusIcon,
      required this.onpressFunc})
      : super(key: key);

  final String greetingText;
  final String orderStatusText;
  final Icon statusIcon;
  final void Function()? onpressFunc;

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
                margin:
                    EdgeInsets.only(left: 60, right: 60, top: 60, bottom: 20),
                // height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(30),
                  color: Colors.white70,
                ),
                padding:
                    EdgeInsets.only(left: 60, right: 60, top: 60, bottom: 60),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        size: 150,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: statusIcon,
                    ),
                  ],
                )
                // child: Image.asset('assets/images/order_success.png'),
                ),
            Container(
              child: Text(
                greetingText,
                style: kBold.copyWith(fontSize: 50),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    orderStatusText,
                    style: kBold.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 70),
              child: Text(
                'Return to Home Page',
                style: kSemibold.copyWith(fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: SaveButton(
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
