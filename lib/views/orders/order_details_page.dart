import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/widgets/top_heading.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key, required this.orderDetails})
      : super(key: key);

  final UserOrders orderDetails;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Container(
          // color: Colors.red,
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),

        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 0.1,
            onPressed: () {
              // Navigator.of(context).pushNamed('settingsPage');
            },
            icon: Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Order Details
              Center(
                child: TopHeading(txt: 'Order Details'),
              ),
              Container(
                height: 650,
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(
                  top: _mediaQuery.size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Id: ${orderDetails.orderId}',
                      style: kSemibold.copyWith(fontSize: 13),
                    ),
                    Text(
                      'Order Time: ${orderDetails.orderTime}',
                      style: kSemibold.copyWith(fontSize: 13),
                    ),
                    Text(
                      'Mode of Payment: ${UserMethods.getModeOfPayment(orderDetails.modeOfPayment)}',
                      style: kSemibold.copyWith(fontSize: 13),
                    ),
                    Row(
                      children: [
                        Text(
                          'Order Status: ',
                          style: kSemibold.copyWith(fontSize: 13),
                        ),
                        Text(
                          orderDetails.orderStatus,
                          style: kSemibold.copyWith(
                              fontSize: 13,
                              color: UserMethods.getColorBasedOnOrderStatus(
                                  orderDetails.orderStatus)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Products Ordered:',
                      style: kBold.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.red.withOpacity(0.1),
                      height: 480,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            _mediaQuery.size.width * 0.04),
                                        color: kColorProductTitleBg,
                                      ),
                                      // padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(12),
                                      child: Image.network(orderDetails
                                          .orderedProducts[index].imagefront),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 110,
                                      // color: Colors.purple.withOpacity(0.2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            orderDetails
                                                .orderedProducts[index].name,
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Size: ${orderDetails.orderedProducts[index].size}',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Quantity: ${orderDetails.orderedProducts[index].quantity}',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Price: ₹${orderDetails.orderedProducts[index].price}.00',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Composition: ${orderDetails.orderedProducts[index].composition}',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Fit: ${orderDetails.orderedProducts[index].fit}',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                          Text(
                                            'Product Id: ${orderDetails.orderedProducts[index].productId}',
                                            style: kSemibold.copyWith(
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 150,
                                width: _mediaQuery.size.width,
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: orderDetails.orderedProducts.length),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Total: ₹${orderDetails.amountPaid}.00',
                        style: kSemibold.copyWith(fontSize: 20),
                      ),
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
