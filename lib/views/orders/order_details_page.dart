import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/bold_text.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/semibold_text.dart';
import 'package:murpanara/widgets/address_text_widget.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/top_heading.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key, required this.orderDetails})
      : super(key: key);

  final UserOrders orderDetails;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: _mediaQuery.size.width * 0.065,
            color: kColorBackIconForgotPassPage,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 0.1,
            onPressed: () {},
            icon: const Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: _mediaQuery.size.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Order Details
              Center(
                child: TopHeading(
                    margin: EdgeInsets.symmetric(
                      vertical: _mediaQuery.size.height * 0.033,
                    ),
                    fontSize: _mediaQuery.size.height * 0.028,
                    txt: 'Order Details'),
              ),
              Container(
                height: _mediaQuery.size.height * 0.78,
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      txt: 'Order Information',
                      fontSize: _mediaQuery.size.height * 0.02,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.006,
                    ),
                    SemiBoldText(
                      txt: 'Order Id: ${orderDetails.orderId}',
                      fontSize: _mediaQuery.size.height * 0.0135,
                    ),
                    SemiBoldText(
                      txt: 'Order Time: ${orderDetails.orderTime}',
                      fontSize: _mediaQuery.size.height * 0.0135,
                    ),
                    SemiBoldText(
                      txt:
                          'Mode of Payment: ${UserMethods.getModeOfPayment(orderDetails.modeOfPayment)}',
                      fontSize: _mediaQuery.size.height * 0.0135,
                    ),
                    Row(
                      children: [
                        SemiBoldText(
                          txt: 'Order Status: ',
                          fontSize: _mediaQuery.size.height * 0.0135,
                        ),
                        Text(
                          orderDetails.orderStatus,
                          style: kSemibold.copyWith(
                            fontSize: _mediaQuery.size.height * 0.014,
                            color: UserMethods.getColorBasedOnOrderStatus(
                                orderDetails.orderStatus),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.03,
                    ),
                    BoldText(
                      txt: 'Delivery Address',
                      fontSize: _mediaQuery.size.height * 0.02,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.006,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.15,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              AddressTextWidget(
                                txt: '${deliveryAddressData.firstName} ',
                                fontSize: _mediaQuery.size.height * 0.0135,
                              ),
                              AddressTextWidget(
                                txt: deliveryAddressData.lastName,
                                fontSize: _mediaQuery.size.height * 0.0135,
                              )
                            ],
                          ),
                          AddressTextWidget(
                            txt: deliveryAddressData.addressLine1,
                            fontSize: _mediaQuery.size.height * 0.0135,
                          ),
                          AddressTextWidget(
                            txt: deliveryAddressData.addressLine2,
                            fontSize: _mediaQuery.size.height * 0.0135,
                          ),
                          AddressTextWidget(
                            txt: deliveryAddressData.pincode.toString(),
                            fontSize: _mediaQuery.size.height * 0.0135,
                          ),
                          Row(
                            children: [
                              AddressTextWidget(
                                txt: '${deliveryAddressData.city}, ',
                                fontSize: _mediaQuery.size.height * 0.0135,
                              ),
                              AddressTextWidget(
                                txt: deliveryAddressData.state,
                                fontSize: _mediaQuery.size.height * 0.0135,
                              ),
                            ],
                          ),
                          AddressTextWidget(
                            txt: deliveryAddressData.country,
                            fontSize: _mediaQuery.size.height * 0.0135,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_android_outlined,
                                size: _mediaQuery.size.height * 0.014,
                              ),
                              SizedBox(
                                width: _mediaQuery.size.width * 0.006,
                              ),
                              AddressTextWidget(
                                txt:
                                    '+91 ${deliveryAddressData.phone.toString()}',
                                fontSize: _mediaQuery.size.height * 0.0135,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    BoldText(
                      txt: 'Products Ordered',
                      fontSize: _mediaQuery.size.height * 0.02,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.006,
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.35,
                      width: _mediaQuery.size.width,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      _mediaQuery.size.width * 0.04),
                                ),
                                height: _mediaQuery.size.height * 0.17,
                                width: _mediaQuery.size.width,
                                child: Row(
                                  children: [
                                    //Image
                                    Container(
                                      width: _mediaQuery.size.width * 0.24,
                                      height: _mediaQuery.size.height * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _mediaQuery.size.width * 0.04),
                                        color: kColorProductTitleBg,
                                      ),
                                      margin: EdgeInsets.all(
                                        _mediaQuery.size.height * 0.013,
                                      ),
                                      child: Image.network(
                                        orderDetails
                                            .orderedProducts[index].imagefront,
                                      ),
                                    ),

                                    SizedBox(
                                      width: _mediaQuery.size.width * 0.53,
                                      height: _mediaQuery.size.height * 0.14,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SemiBoldText(
                                            txt: orderDetails
                                                .orderedProducts[index].name,
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Size: ${orderDetails.orderedProducts[index].size}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Quantity: ${orderDetails.orderedProducts[index].quantity}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Price: ₹${orderDetails.orderedProducts[index].price}.00',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Composition: ${orderDetails.orderedProducts[index].composition}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Fit: ${orderDetails.orderedProducts[index].fit}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                          SemiBoldText(
                                            txt:
                                                'Product Id: ${orderDetails.orderedProducts[index].productId}',
                                            fontSize: _mediaQuery.size.height *
                                                0.0135,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: _mediaQuery.size.height * 0.01,
                              ),
                          itemCount: orderDetails.orderedProducts.length),
                    ),
                    SizedBox(
                      height: _mediaQuery.size.height * 0.017,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SemiBoldText(
                          txt: 'Total',
                          fontSize: _mediaQuery.size.height * 0.026,
                        ),
                        SemiBoldText(
                          txt: '₹${orderDetails.amountPaid}.00',
                          fontSize: _mediaQuery.size.height * 0.026,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
