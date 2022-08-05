import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/views/orders/order_details_page.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/semibold_text.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/top_heading.dart';
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
              Center(
                child: TopHeading(
                    margin: EdgeInsets.symmetric(
                        vertical: _mediaQuery.size.height * 0.033),
                    fontSize: _mediaQuery.size.height * 0.028,
                    txt: 'Your Orders'),
              ),

              //Orders List
              Container(
                height: _mediaQuery.size.height * 0.75,
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: userOrdersData.isEmpty
                    ? Center(
                        child: SemiBoldText(
                          txt: 'You haven\'t placed any orders yet.',
                          fontSize: _mediaQuery.size.width * 0.042,
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  _mediaQuery.size.width * 0.04,
                                ),
                              ),
                              height: _mediaQuery.size.height * 0.2,
                              width: _mediaQuery.size.width,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            _mediaQuery.size.width * 0.018),
                                    height: _mediaQuery.size.height * 0.08,
                                    child: Image.network(userOrdersData[index]
                                        .orderedProducts
                                        .first
                                        .imagefront),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: _mediaQuery.size.height * 0.01,
                                    ),
                                    padding: EdgeInsets.all(
                                      _mediaQuery.size.height * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SemiBoldText(
                                          txt:
                                              'Order Id: ${(userOrdersData[index].orderId).substring(0, 14)}..',
                                          fontSize:
                                              _mediaQuery.size.height * 0.0135,
                                        ),
                                        SemiBoldText(
                                          txt:
                                              'Order Time: ${(userOrdersData[index].orderTime).substring(0, 19)}',
                                          fontSize:
                                              _mediaQuery.size.height * 0.0135,
                                        ),
                                        SemiBoldText(
                                          txt:
                                              'Total Items: ${userOrdersData[index].orderedProducts.length}',
                                          fontSize:
                                              _mediaQuery.size.height * 0.0135,
                                        ),
                                        SemiBoldText(
                                          txt:
                                              'Mode of Payment: ${UserMethods.getModeOfPayment(userOrdersData[index].modeOfPayment)}',
                                          fontSize:
                                              _mediaQuery.size.height * 0.0135,
                                        ),
                                        Row(
                                          children: [
                                            SemiBoldText(
                                              txt: 'Order Status: ',
                                              fontSize:
                                                  _mediaQuery.size.height *
                                                      0.0135,
                                            ),
                                            Text(
                                              userOrdersData[index].orderStatus,
                                              style: kSemibold.copyWith(
                                                fontSize:
                                                    _mediaQuery.size.height *
                                                        0.014,
                                                color: UserMethods
                                                    .getColorBasedOnOrderStatus(
                                                        userOrdersData[index]
                                                            .orderStatus),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              _mediaQuery.size.height * 0.04,
                                          width: _mediaQuery.size.width * 0.55,
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
                                                                index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Details',
                                                      style: kBold.copyWith(
                                                        fontSize: _mediaQuery
                                                                .size.height *
                                                            0.017,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_outlined,
                                                      size: _mediaQuery
                                                              .size.width *
                                                          0.05,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SemiBoldText(
                                                txt:
                                                    'Total: ₹${userOrdersData[index].amountPaid}.00',
                                                fontSize:
                                                    _mediaQuery.size.height *
                                                        0.017,
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
                        separatorBuilder: (context, index) => SizedBox(
                              height: _mediaQuery.size.height * 0.01,
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
