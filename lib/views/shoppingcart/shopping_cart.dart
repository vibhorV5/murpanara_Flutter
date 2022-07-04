import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:murpanara/views/shoppingcart/shoppping_cart_item_tile.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    initializeRazorpay();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
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
      'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: kColorShoppingCartPageBg,
      body: Column(
        children: [
          //Shopping Cart(title)
          Container(
            margin: EdgeInsets.only(
                top: _mediaQuery.size.height * 0.04,
                bottom: _mediaQuery.size.height * 0.03,
                left: _mediaQuery.size.width * 0.04,
                right: _mediaQuery.size.width * 0.04),
            alignment: Alignment.centerLeft,
            child: Text(
              'Shopping Cart',
              style: kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
            ),
          ),

          Container(
            // color: Colors.black.withOpacity(0.3),
            child: StreamBuilder(
              stream: DatabaseServices().shoppingCartProductStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Stack(
                    children: [
                      Container(
                        height: _mediaQuery.size.height * 0.6,
                        width: _mediaQuery.size.width,
                        child: Center(
                          child: Text(''),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: _mediaQuery.size.height * 0.4),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data!;
                  List<ShoppingCartProduct> product =
                      data as List<ShoppingCartProduct>;

                  _getSum(data);

                  return data.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          // color: Colors.orange,
                          height: _mediaQuery.size.height * 0.6,
                          width: _mediaQuery.size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 100),
                                // height: _mediaQuery.size.height * 0.2,
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black.withOpacity(0.8),
                                  size: _mediaQuery.size.height * 0.12,
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(
                                    top: _mediaQuery.size.height * 0.02),
                                child: Text(
                                  'Your Shopping Cart is empty.',
                                  style: kSemibold.copyWith(
                                    fontSize: _mediaQuery.size.height * 0.027,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: _mediaQuery.size.height * 0.01),
                                child: Text(
                                  'Looks like you haven\'t added anything to your cart yet.',
                                  style: kRegular.copyWith(
                                    fontSize: _mediaQuery.size.height * 0.018,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),

                              //Shop Now Button
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (Route<dynamic> route) => false);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: _mediaQuery.size.height * 0.025),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(
                                        _mediaQuery.size.height * 0.04),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _mediaQuery.size.width * 0.07,
                                      vertical:
                                          _mediaQuery.size.height * 0.014),
                                  child: Text(
                                    'Continue Shopping',
                                    style:
                                        kSemibold.copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          // color: Colors.purple,
                          child: Column(
                            children: [
                              Container(
                                height: _mediaQuery.size.height * 0.5,
                                width: _mediaQuery.size.width,
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ShoppingCartItemTile(
                                          product: product[index]);
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: _mediaQuery.size.height * 0.025,
                                      );
                                    },
                                    itemCount: product.length),
                              ),
                              Container(
                                height: _mediaQuery.size.height * 0.1,
                                // color: Colors.orange,
                                margin: EdgeInsets.only(
                                    left: _mediaQuery.size.width * 0.04,
                                    right: _mediaQuery.size.width * 0.08),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Total',
                                        style: kTotalSumTextStyle.copyWith(
                                            fontSize:
                                                _mediaQuery.size.height * 0.03),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '₹${_getSum(data)}',
                                        style: kTotalSumTextStyle2.copyWith(
                                            fontSize:
                                                _mediaQuery.size.height * 0.03),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Checkout Button
                              CartButton(
                                  mediaQuery: _mediaQuery,
                                  cartFunction: launchRazorpay),
                            ],
                          ),
                        );
                } else if (snapshot.hasError) {
                  return Container(
                    child: Text('Error'),
                  );
                } else {
                  return Container(
                    child: Text('Check database'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  num _getSum(List<ShoppingCartProduct> data) {
    num sum = 0;
    for (ShoppingCartProduct item in data) {
      sum = sum + (item.price * item.quantity);
    }

    print(sum);
    return sum;
  }
}

class CartButton extends StatelessWidget {
  CartButton(
      {Key? key,
      required MediaQueryData mediaQuery,
      required this.cartFunction})
      : _mediaQuery = mediaQuery,
        super(key: key);

  final MediaQueryData _mediaQuery;
  Function cartFunction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {
        cartFunction();
      },
      child: Container(
        margin: EdgeInsets.only(
            top: _mediaQuery.size.height * 0.02,
            // bottom: _mediaQuery.size.height * 0.02,
            left: _mediaQuery.size.width * 0.06,
            right: _mediaQuery.size.width * 0.06),
        alignment: Alignment.center,
        height: _mediaQuery.size.height * 0.065,
        width: _mediaQuery.size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(_mediaQuery.size.height * 0.5),
        ),
        // color: Colors.amber,
        child: Text(
          'Checkout',
          style: kAddToCartTextStyle.copyWith(
              color: Colors.white, fontSize: _mediaQuery.size.height * 0.02),
        ),
      ),
    );
  }
}
