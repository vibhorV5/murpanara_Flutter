import 'package:flutter/material.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black.withOpacity(0.3),
            child: StreamBuilder(
              stream: DatabaseServices().shoppingCartProductStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else if (snapshot.hasData) {
                  var data = snapshot.data!;
                  List<ShoppingCartProduct> product =
                      data as List<ShoppingCartProduct>;

                  _getSum(data);

                  return Column(
                    children: [
                      Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                        height: 50,
                                        child: Image.network(
                                            product[index].imagefront)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(product[index].name),
                                        GestureDetector(
                                          onTap: () async {
                                            await DatabaseServices()
                                                .deleteShoppingCartItemOnFirestore(
                                                    shoppingCartProduct:
                                                        product[index]);

                                            print('deleted');
                                            print('done');
                                          },
                                          child: Container(
                                            child: Text('Delete item'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(product[index].size),
                                    Text('${product[index].quantity}'),
                                    Text('${product[index].price}'),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: product.length),
                      ),
                      Text('${_getSum(data)} ₹'),
                    ],
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
          Center(
              child: TextButton(
            onPressed: () {
              launchRazorpay();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              color: Colors.black,
              child: Text(
                'Pay Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )),
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
