import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/save_button.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({Key? key}) : super(key: key);

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
              margin: EdgeInsets.only(left: 60, right: 60, top: 60, bottom: 20),
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(30),
                color: Colors.white70,
              ),
              padding:
                  EdgeInsets.only(left: 60, right: 45, top: 60, bottom: 60),
              child: Image.asset('assets/images/order_success.png'),
            ),
            Container(
              child: Text(
                'Thank You!',
                style: kBold.copyWith(fontSize: 50),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Order Placed Successfully',
                    style: kBold.copyWith(fontSize: 18),
                  ),
                ),
                Icon(
                  Icons.done,
                  color: Colors.green,
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
                onPress: () async {
                  await DatabaseServices().clearShoppingCartList();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
