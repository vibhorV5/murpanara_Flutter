import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/simple_heading.dart';
import 'package:murpanara/widgets/simple_small_heading.dart';
import 'package:murpanara/widgets/small_info_text.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

enum ModeOfPayment { razorPay, cashOnDelivery }

class _CheckoutPageState extends State<CheckoutPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Successfvdfull');

    print(
        'hello = ${response.orderId} \n ${response.paymentId} \n ${response.signature}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Failed');

    print('${response.code} \n ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('Payment Failed');
  }

  void launchRazorpay() {
    var options = {
      'key': 'rzp_test_Afbk6Y8rJy3NHQ',
      'amount': 50000, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {
        'contact': '9123456789',
        'email': 'gaurav.kumar@example.com',
        'orderdetails': 'bla bla bla'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);
    List<ShoppingCartProduct> shoppingCartProductsList =
        Provider.of<List<ShoppingCartProduct>>(context);

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: _mediaQuery.size.width,
            // color: Colors.red.withOpacity(0.3),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 130,
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        // color: Colors.yellow,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(
                              //   top: _mediaQuery.size.height * 0.015,
                              // ),

                              // color: Colors.blueAccent,
                              child: Icon(Icons.arrow_back_ios_new_outlined,
                                  size: _mediaQuery.size.width * 0.065,
                                  color: kColorBackIconForgotPassPage),
                            ),
                            // SimpleSmallHeading(txt: 'Shopping Cart')
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        // color: Colors.blue,
                        height: 30,
                        width: 120,
                        child: Image.asset(
                          'assets/images/mpr_main.png',
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),

                //My Information
                Container(
                  width: _mediaQuery.size.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(
                    top: _mediaQuery.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleHeading(
                        txt: 'My Information',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SimpleSmallHeading(
                        txt: 'Email',
                      ),
                      AddressTextWidget(
                        mediaQuery: _mediaQuery,
                        txt: 'vibhor.stav@gmail.com',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SimpleSmallHeading(
                        txt: 'Phone',
                      ),
                      AddressTextWidget(
                        mediaQuery: _mediaQuery,
                        txt: '+91 8126793405',
                      ),
                    ],
                  ),
                ),

                //Delivery Details
                Container(
                  width: _mediaQuery.size.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(
                    top: _mediaQuery.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleHeading(
                        txt: 'Delivery Details',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (deliveryAddressData.addressLine1.isEmpty ||
                              deliveryAddressData.addressLine2.isEmpty ||
                              deliveryAddressData.city.isEmpty ||
                              deliveryAddressData.pincode == 0)
                          ? Container(
                              child: SmallInfoText(
                                  txt: 'No Delivery address found'),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.redAccent.withOpacity(0.4),
                                  height: 100,
                                  width: 180,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                            txt:
                                                '${deliveryAddressData.firstName} ',
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt: deliveryAddressData.lastName,
                                            mediaQuery: _mediaQuery,
                                          )
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: deliveryAddressData.addressLine1,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: deliveryAddressData.addressLine2,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: deliveryAddressData.pincode
                                            .toString(),
                                        mediaQuery: _mediaQuery,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt:
                                                  '${deliveryAddressData.city} ',
                                              mediaQuery: _mediaQuery),
                                          AddressTextWidget(
                                              txt: deliveryAddressData.state,
                                              mediaQuery: _mediaQuery),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: deliveryAddressData.country,
                                        mediaQuery: _mediaQuery,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),

                //Order Details
                Container(
                  width: _mediaQuery.size.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(
                    top: _mediaQuery.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleHeading(
                        txt: 'Order Details',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        height: 180,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: shoppingCartProductsList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.red,
                                  height: 70,
                                  child: Image.network(
                                      shoppingCartProductsList[index]
                                          .imagefront),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      width: 150,
                                      // color: Colors.pink,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AddressTextWidget(
                                            txt: shoppingCartProductsList[index]
                                                .name,
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Size: ${shoppingCartProductsList[index].size}',
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Price: ${shoppingCartProductsList[index].price.toString()}.00',
                                            mediaQuery: _mediaQuery,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          'x ${shoppingCartProductsList[index].quantity.toString()}',
                                      mediaQuery: _mediaQuery,
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          '${getProductPrice(price: shoppingCartProductsList[index].price, quantity: shoppingCartProductsList[index].quantity)}.00',
                                      mediaQuery: _mediaQuery,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SimpleHeading(txt: 'Total'),
                          SimpleHeading(
                            txt: '${getSum(shoppingCartProductsList)}.00',
                          )
                        ],
                      )
                    ],
                  ),
                ),

                //Mode of Payment
                Container(
                  width: _mediaQuery.size.width,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(
                    top: _mediaQuery.size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleHeading(
                        txt: 'Mode of Payment',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text('RazorPay'),
                      ),
                      ListTile(
                        title: Text('Cash on Delivery'),
                      ),
                      // SimpleSmallHeading(
                      //   txt: 'Email',
                      // ),
                      // SimpleText(
                      //   txt: 'vibhor.stav@gmail.com',
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // SimpleSmallHeading(
                      //   txt: 'Phone',
                      // ),
                      // SimpleText(
                      //   txt: '+91 8126793405',
                      // ),
                    ],
                  ),
                ),

                SaveButton(
                  mediaQuery: _mediaQuery,
                  txt: 'CONTINUE TO PAYMENT',
                  color: Colors.black,
                  txtColor: Colors.white,
                  onPress: () {
                    launchRazorpay();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  num getProductPrice({required num price, required num quantity}) {
    return (price * quantity);
  }

  num getSum(List<ShoppingCartProduct> data) {
    num sum = 0;
    for (ShoppingCartProduct item in data) {
      sum = sum + (item.price * item.quantity);
    }

    print(sum);
    return sum;
  }
}
