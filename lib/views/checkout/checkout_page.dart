import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/order_success_failure/order_success_failure_page.dart';
import 'package:murpanara/widgets/CheckoutPageWidgets/custom_radiotile_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/small_info_text.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.email,
    required this.deliveryAddress,
    required this.shoppingList,
    required this.totalSum,
    required this.productListDesc,
    required this.generatedOrderID,
    required this.checkoutDetailsProvider,
  }) : super(key: key);

  final String email;
  final DeliveryAddress deliveryAddress;
  final num totalSum;
  final List<ShoppingCartProduct> shoppingList;
  final List<dynamic> productListDesc;
  final String generatedOrderID;
  final CheckoutDetailsProvider checkoutDetailsProvider;

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
    debugPrint('Payment Successfull');
    debugPrint('Order created with OrderId:${widget.generatedOrderID}');
    // debugPrint('TIME: ${UserMethods.getCurrentDateTime(orderTime)}');

    debugPrint(
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

    debugPrint('Orders set');
    debugPrint('User order set success');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessFailurePage(
          statusText: 'Success',
          greetingText: 'Thank You!',
          orderStatusText: 'Order Placed Successfully',
          onpressFunc: () async {
            await DatabaseServices().clearShoppingCartList();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails

    debugPrint('Payment Failed');
    debugPrint('${response.code} \n ${response.message}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessFailurePage(
          statusText: 'Failed',
          greetingText: 'Oops!',
          orderStatusText: 'Payment error, Please try again.',
          onpressFunc: () async {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    debugPrint('Payment Failed');
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
      debugPrint('Error = $e');
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
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: _mediaQuery.size.width,
            margin: EdgeInsets.symmetric(
              horizontal: _mediaQuery.size.width * 0.04,
            ),
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
                        width: _mediaQuery.size.width * 0.3,
                        padding: EdgeInsets.symmetric(
                          vertical: _mediaQuery.size.height * 0.02,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios_new_outlined,
                                size: _mediaQuery.size.width * 0.065,
                                color: kColorBackIconForgotPassPage),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: _mediaQuery.size.height * 0.04,
                        width: _mediaQuery.size.width * 0.3,
                        child: Image.asset(
                          'assets/images/mpr_main.png',
                        ),
                      ),
                    ),
                  ],
                ),

                //My Information
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                  width: _mediaQuery.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingsTitle(
                        titleText: 'My Information',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.025,
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.025,
                      ),
                      HeadingsTitle(
                        titleText: 'Email',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.018,
                      ),
                      AddressTextWidget(
                        fontSize: _mediaQuery.size.height * 0.014,
                        txt: widget.email,
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.018,
                      ),
                      HeadingsTitle(
                        titleText: 'Phone',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.018,
                      ),
                      AddressTextWidget(
                        fontSize: _mediaQuery.size.height * 0.014,
                        txt:
                            '+91 ${UserMethods.checkNumField(widget.deliveryAddress.phone!)}',
                      ),
                    ],
                  ),
                ),

                //Delivery Details
                Container(
                  margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                  width: _mediaQuery.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingsTitle(
                        titleText: 'Delivery Details',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.025,
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.018,
                      ),
                      (widget.deliveryAddress.addressLine1.isEmpty ||
                              widget.deliveryAddress.addressLine2.isEmpty ||
                              widget.deliveryAddress.city.isEmpty ||
                              widget.deliveryAddress.pincode == 0)
                          ? SmallInfoText(
                              margin: EdgeInsets.only(
                                  bottom: _mediaQuery.size.height * 0.002,
                                  top: _mediaQuery.size.height * 0.002),
                              fontSize: _mediaQuery.size.height * 0.03,
                              txt: 'No Delivery address found')
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: _mediaQuery.size.height * 0.11,
                                  width: _mediaQuery.size.width * 0.7,
                                  child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                            txt:
                                                '${widget.deliveryAddress.firstName} ',
                                            fontSize:
                                                _mediaQuery.size.height * 0.014,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                widget.deliveryAddress.lastName,
                                            fontSize:
                                                _mediaQuery.size.height * 0.014,
                                          )
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt:
                                            widget.deliveryAddress.addressLine1,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      AddressTextWidget(
                                        txt:
                                            widget.deliveryAddress.addressLine2,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      AddressTextWidget(
                                        txt: widget.deliveryAddress.pincode
                                            .toString(),
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
                                      ),
                                      Row(
                                        children: [
                                          AddressTextWidget(
                                              txt:
                                                  '${widget.deliveryAddress.city} ',
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.014),
                                          AddressTextWidget(
                                              txt: widget.deliveryAddress.state,
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.014),
                                        ],
                                      ),
                                      AddressTextWidget(
                                        txt: widget.deliveryAddress.country,
                                        fontSize:
                                            _mediaQuery.size.height * 0.014,
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
                  margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                  width: _mediaQuery.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingsTitle(
                        titleText: 'Order Details',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.025,
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.018,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.width * 0.04),
                        ),
                        height: _mediaQuery.size.height * 0.24,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: _mediaQuery.size.height * 0.005,
                            );
                          },
                          itemCount: widget.shoppingList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          _mediaQuery.size.width * 0.018),
                                  height: _mediaQuery.size.height * 0.08,
                                  child: Image.network(
                                      widget.shoppingList[index].imagefront),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          _mediaQuery.size.height * 0.02),
                                      width: _mediaQuery.size.width * 0.32,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.shoppingList[index].name,
                                            style: kBold.copyWith(
                                                fontSize:
                                                    _mediaQuery.size.height *
                                                        0.013),
                                          ),
                                          SizedBox(
                                            height:
                                                _mediaQuery.size.height * 0.001,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Size: ${widget.shoppingList[index].size}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0125,
                                          ),
                                          SizedBox(
                                            height:
                                                _mediaQuery.size.height * 0.001,
                                          ),
                                          AddressTextWidget(
                                            txt:
                                                'Price: ${widget.shoppingList[index].price.toString()}.00',
                                            fontSize: _mediaQuery.size.height *
                                                0.0125,
                                          ),
                                        ],
                                      ),
                                    ),
                                    _mediaQuery.size.height < 600
                                        ? Container()
                                        : SizedBox(
                                            width:
                                                _mediaQuery.size.width * 0.035,
                                          ),
                                    AddressTextWidget(
                                      txt:
                                          'x ${widget.shoppingList[index].quantity.toString()}',
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                    SizedBox(
                                      width: _mediaQuery.size.width * 0.075,
                                    ),
                                    AddressTextWidget(
                                      txt:
                                          '${getProductPrice(price: widget.shoppingList[index].price, quantity: widget.shoppingList[index].quantity)}.00',
                                      fontSize: _mediaQuery.size.height * 0.014,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingsTitle(
                            titleText: 'Total',
                            margin: EdgeInsets.only(
                                left: _mediaQuery.size.width * 0.0001),
                            fontSize: _mediaQuery.size.height * 0.026,
                          ),
                          HeadingsTitle(
                            titleText: '₹${getSum(widget.shoppingList)}.00',
                            margin: EdgeInsets.only(
                                left: _mediaQuery.size.width * 0.0001),
                            fontSize: _mediaQuery.size.height * 0.026,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Mode of Payment
                Container(
                  margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                    color: Colors.grey.shade200,
                  ),
                  padding: EdgeInsets.all(_mediaQuery.size.width * 0.04),
                  width: _mediaQuery.size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingsTitle(
                        titleText: 'Mode of Payment',
                        margin: EdgeInsets.only(
                            bottom: _mediaQuery.size.height * 0.001),
                        fontSize: _mediaQuery.size.height * 0.025,
                      ),
                      SizedBox(
                        height: _mediaQuery.size.height * 0.025,
                      ),
                      CustomRadioTileWidget(
                        fontSize: _mediaQuery.size.height * 0.02,
                      ),
                    ],
                  ),
                ),

                SaveButton(
                  fontSize: _mediaQuery.size.height * 0.02,
                  height: _mediaQuery.size.height * 0.06,
                  borderRadiusGeometry:
                      BorderRadius.circular(_mediaQuery.size.height * 0.04),
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
                          borderRadius: _mediaQuery.size.width * 0.06,
                          contentPadding: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.01
                              : _mediaQuery.size.height * 0.04,
                          contentContainerHeight:
                              _mediaQuery.size.height * 0.24,
                          headingTextTopMargin: _mediaQuery.size.height * 0.02,
                          headingTextFontSize: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.014
                              : _mediaQuery.size.height * 0.024,
                          confirmTextSize: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.012
                              : _mediaQuery.size.height * 0.018,
                          cancelTextSize: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.012
                              : _mediaQuery.size.height * 0.018,
                          subTextSize: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.012
                              : _mediaQuery.size.height * 0.018,
                          mprEyeContainerHeight: _mediaQuery.size.width * 0.07,
                          mprEyeContainerWidth: _mediaQuery.size.width * 0.07,
                          bigSizedBoxHeight: _mediaQuery.size.height < 600
                              ? _mediaQuery.size.height * 0.01
                              : _mediaQuery.size.height * 0.04,
                          smallSizedBoxHeight: _mediaQuery.size.height * 0.03,
                          textButtonHorizontalPadding:
                              _mediaQuery.size.width * 0.05,
                          textButtonVerticalpadding:
                              _mediaQuery.size.height * 0.008,
                          textButtonBorderRadius: _mediaQuery.size.width * 0.06,
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
                            // print('COD SELECTED SUCCESS');
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSuccessFailurePage(
                                  statusText: 'Success',
                                  greetingText: 'Thank You!',
                                  orderStatusText: 'Order Placed Successfully',
                                  onpressFunc: () async {
                                    await DatabaseServices()
                                        .clearShoppingCartList();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/',
                                            (Route<dynamic> route) => false);
                                  },
                                ),
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

    debugPrint(sum.toString());
    return sum;
  }
}
