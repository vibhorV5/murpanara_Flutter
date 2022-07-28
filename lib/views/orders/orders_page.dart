import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/views/orders/order_details_page.dart';
import 'package:murpanara/widgets/top_heading.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    List<UserOrders> userOrdersData = Provider.of<List<UserOrders>>(context);

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      // backgroundColor: Colors.white,

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
              //Your Orders
              Center(
                child: TopHeading(txt: 'Your Orders'),
              ),

              //Orders List
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
                child: userOrdersData.isEmpty
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text(
                            'You haven\'t placed any orders yet.',
                            style: kSemibold.copyWith(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 150,
                              width: _mediaQuery.size.width,
                              child: Row(
                                children: [
                                  Container(
                                    // color: Colors.blue,
                                    height: 120,
                                    width: 75,
                                    child: Image.network(userOrdersData[index]
                                        .orderedProducts
                                        .first
                                        .imagefront),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.all(10),
                                    // color: Colors.blueGrey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order Id: ${userOrdersData[index].orderId}',
                                          style:
                                              kSemibold.copyWith(fontSize: 11),
                                        ),
                                        Text(
                                          'Order Time: ${userOrdersData[index].orderTime}',
                                          style:
                                              kSemibold.copyWith(fontSize: 11),
                                        ),
                                        Text(
                                          'Total Items: ${userOrdersData[index].orderedProducts.length}',
                                          style:
                                              kSemibold.copyWith(fontSize: 11),
                                        ),
                                        Text(
                                          'Mode of Payment: ${UserMethods.getModeOfPayment(userOrdersData[index].modeOfPayment)}',
                                          style:
                                              kSemibold.copyWith(fontSize: 11),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Order Status: ',
                                              style: kSemibold.copyWith(
                                                  fontSize: 11),
                                            ),
                                            Text(
                                              userOrdersData[index].orderStatus,
                                              style: kSemibold.copyWith(
                                                  fontSize: 11,
                                                  color: UserMethods
                                                      .getColorBasedOnOrderStatus(
                                                          userOrdersData[index]
                                                              .orderStatus)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          width: 250,
                                          // color: Colors.yellow,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrderDetailsPage(
                                                                  orderDetails:
                                                                      userOrdersData[
                                                                          index])));
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      // color: Colors.amberAccent,
                                                      child: Text(
                                                        'Details',
                                                        style: kBold.copyWith(
                                                          fontSize: 15,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                        size: _mediaQuery
                                                                .size.width *
                                                            0.05,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 50,
                                              // ),
                                              Text(
                                                'Total: ₹${userOrdersData[index].amountPaid}.00',
                                                style: kSemibold.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: userOrdersData.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
