import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/order_success/order_success_page.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/cancel_button.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/simple_heading.dart';
import 'package:murpanara/widgets/simple_small_heading.dart';
import 'package:murpanara/widgets/small_info_text.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({
    Key? key,
    required this.email,
    required this.deliveryAddress,
    required this.shoppingList,
    required this.totalSum,
    required this.productListDesc,
    required this.generatedOrderID,
    required this.checkoutDetailsProvider,
  }) : super(key: key);

  String email;
  DeliveryAddress deliveryAddress;
  num totalSum;
  List<ShoppingCartProduct> shoppingList;
  List<dynamic> productListDesc;
  String generatedOrderID;
  CheckoutDetailsProvider checkoutDetailsProvider;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

enum ModeOfPayment { razorPay, cashOnDelivery }

class _CheckoutPageState extends State<CheckoutPage> {
  ModeOfPayment? paymentModeSelect = ModeOfPayment.razorPay;

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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print('Payment Successfvdfull');
    print('Order created with OrderId:${widget.generatedOrderID}');
    // print('TIME: ${UserMethods.getCurrentDateTime(orderTime)}');

    print(
        'hello = ${response.orderId} \n ${response.paymentId} \n ${response.signature}');

    await DatabaseServices().setUserOrder(
      userOrders: UserOrders(
        firstName: widget.deliveryAddress.firstName,
        lastName: widget.deliveryAddress.lastName,
        modeOfPayment: widget
            .checkoutDetailsProvider.currentSelectedModeOfPayment
            .toString(),
        orderId: widget.checkoutDetailsProvider.generateOrderId(),
        orderStatus: 'Order Placed',
        orderTime: widget.checkoutDetailsProvider.currentOrderTime().toString(),
        orderedProducts: widget.shoppingList,
        phone: widget.deliveryAddress.phone,
        amountPaid: widget.totalSum,
        deliveryAddress:
            ('FIRST NAME - ${widget.deliveryAddress.firstName},LAST NAME - ${widget.deliveryAddress.lastName},HOUSE/FLAT NO. - ${widget.deliveryAddress.addressLine1},STREET - ${widget.deliveryAddress.addressLine2},CITY - ${widget.deliveryAddress.city},STATE - ${widget.deliveryAddress.state},PINCODE - ${widget.deliveryAddress.pincode},COUNTRY - ${widget.deliveryAddress.country}'),
        emailId: widget.email,
      ),
    );
    print('Orders set');

    print('User order set success');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderSuccessPage(),
      ),
    );
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
      'amount': widget.totalSum * 100, //in the smallest currency sub-unit.
      'name': 'murpanara',
      // 'order_id': widget.generatedOrderID, // Generate order_id using Orders API
      'description':
          'Order ID: ${widget.generatedOrderID} Details: ${widget.productListDesc.toString()}',
      'timeout': 120, // in seconds
      'prefill': {
        'contact': widget.deliveryAddress.phone,
        'email': widget.email,
        'orderdetails': 'widget.shoppingList.toString()',
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
    CheckoutDetailsProvider checkoutDetailsProviderData =
        Provider.of<CheckoutDetailsProvider>(context);
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
                        // txt: 'vibhor.stav@gmail.com',
                        txt: widget.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SimpleSmallHeading(
                        txt: 'Phone',
                      ),
                      AddressTextWidget(
                        mediaQuery: _mediaQuery,
                        // txt: '+91 8126793405',
                        txt:
                            '+91 ${UserMethods.checkNumField(widget.deliveryAddress.phone!)}',
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
                      (widget.deliveryAddress.addressLine1.isEmpty ||
                              widget.deliveryAddress.addressLine2.isEmpty ||
                              widget.deliveryAddress.city.isEmpty ||
                              widget.deliveryAddress.pincode == 0)
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
                                                '${widget.deliveryAddress.firstName} ',
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                widget.deliveryAddress.lastName,
                                            mediaQuery: _mediaQuery,
                                          )
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt:
                                            widget.deliveryAddress.addressLine1,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt:
                                            widget.deliveryAddress.addressLine2,
                                        mediaQuery: _mediaQuery,
                                      ),
                                      AddressTextWidget(
                                        txt: widget.deliveryAddress.pincode
                                            .toString(),
                                        mediaQuery: _mediaQuery,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt:
                                                  '${widget.deliveryAddress.city} ',
                                              mediaQuery: _mediaQuery),
                                          AddressTextWidget(
                                              txt: widget.deliveryAddress.state,
                                              mediaQuery: _mediaQuery),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: widget.deliveryAddress.country,
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
                          itemCount: widget.shoppingList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  // color: Colors.red,
                                  height: 70,
                                  child: Image.network(
                                      widget.shoppingList[index].imagefront),
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
                                            txt:
                                                widget.shoppingList[index].name,
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Size: ${widget.shoppingList[index].size}',
                                            mediaQuery: _mediaQuery,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Price: ${widget.shoppingList[index].price.toString()}.00',
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
                                          'x ${widget.shoppingList[index].quantity.toString()}',
                                      mediaQuery: _mediaQuery,
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          '${getProductPrice(price: widget.shoppingList[index].price, quantity: widget.shoppingList[index].quantity)}.00',
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
                            txt: '${getSum(widget.shoppingList)}.00',
                          )
                        ],
                      ),
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
                  child: CustomRadioTileWidget(),
                ),

                SaveButton(
                  mediaQuery: _mediaQuery,
                  txt: 'CONTINUE TO PAYMENT',
                  color: Colors.black,
                  txtColor: Colors.white,
                  onPress: () async {
                    {
                      if (checkoutDetailsProviderData
                              .currentSelectedModeOfPayment ==
                          ModeOfPayment.razorPay) {
                        launchRazorpay();
                      } else if (checkoutDetailsProviderData
                              .currentSelectedModeOfPayment ==
                          ModeOfPayment.cashOnDelivery) {
                        UserMethods.customDialogBox(
                          cancelText: 'Cancel',
                          confirmText: 'Place Order',
                          context: context,
                          mediaQuery: _mediaQuery,
                          headingText: 'ORDER CONFIRMATION',
                          subText: 'Do you want to place this order?',
                          confirmFunction: () async {
                            await DatabaseServices().setUserOrder(
                              userOrders: UserOrders(
                                firstName: widget.deliveryAddress.firstName,
                                lastName: widget.deliveryAddress.lastName,
                                modeOfPayment: widget.checkoutDetailsProvider
                                    .currentSelectedModeOfPayment
                                    .toString(),
                                orderId: widget.checkoutDetailsProvider
                                    .generateOrderId(),
                                orderStatus: 'Processing',
                                orderTime: widget.checkoutDetailsProvider
                                    .currentOrderTime()
                                    .toString(),
                                orderedProducts: widget.shoppingList,
                                phone: widget.deliveryAddress.phone,
                                amountPaid: widget.totalSum,
                                deliveryAddress:
                                    ('FIRST NAME - ${widget.deliveryAddress.firstName},LAST NAME - ${widget.deliveryAddress.lastName},HOUSE/FLAT NO. - ${widget.deliveryAddress.addressLine1},STREET - ${widget.deliveryAddress.addressLine2},CITY - ${widget.deliveryAddress.city},STATE - ${widget.deliveryAddress.state},PINCODE - ${widget.deliveryAddress.pincode},COUNTRY - ${widget.deliveryAddress.country}'),
                                emailId: widget.email,
                              ),
                            );
                            print('COD SELECTED SUCCESS');
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrderSuccessPage(),
                              ),
                            );
                          },
                        );
                      }
                    }
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

class CustomRadioTileWidget extends StatefulWidget {
  const CustomRadioTileWidget({Key? key}) : super(key: key);

  @override
  State<CustomRadioTileWidget> createState() => _CustomRadioTileWidgetState();
}

class _CustomRadioTileWidgetState extends State<CustomRadioTileWidget> {
  @override
  Widget build(BuildContext context) {
    CheckoutDetailsProvider checkoutDetailsProviderData =
        Provider.of<CheckoutDetailsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleHeading(
          txt: 'Mode of Payment',
        ),
        SizedBox(
          height: 20,
        ),
        RadioListTile<ModeOfPayment>(
          value: ModeOfPayment.razorPay,
          groupValue: checkoutDetailsProviderData.currentSelectedModeOfPayment,
          onChanged: (ModeOfPayment? value) {
            setState(() {
              checkoutDetailsProviderData.modeOfPaymentValue(value!);
              // paymentModeSelect = value;
              print(checkoutDetailsProviderData.currentSelectedModeOfPayment);
            });
          },
          title: Text('RazorPay'),
        ),
        RadioListTile<ModeOfPayment>(
          value: ModeOfPayment.cashOnDelivery,
          groupValue: checkoutDetailsProviderData.currentSelectedModeOfPayment,
          onChanged: (ModeOfPayment? value) {
            setState(() {
              // paymentModeSelect = value;
              checkoutDetailsProviderData.modeOfPaymentValue(value!);
              print(checkoutDetailsProviderData.currentSelectedModeOfPayment);
            });
          },
          title: Text('Cash on Delivery'),
        ),
      ],
    );
  }
}
