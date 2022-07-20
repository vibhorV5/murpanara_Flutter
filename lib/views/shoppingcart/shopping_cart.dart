import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:provider/provider.dart';
import 'package:murpanara/views/shoppingcart/shoppping_cart_item_tile.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    // BillingAddress billingAddressData = Provider.of<BillingAddress>(context);
    // DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);
    // CheckoutDetailsProvider checkoutDetailsProvider =
    //     Provider.of<CheckoutDetailsProvider>(context);
    // PersonalDetails personalDetailsData = Provider.of<PersonalDetails>(context);
    // List<ShoppingCartProduct> shoppingCartProductsList =
    //     Provider.of<List<ShoppingCartProduct>>(context);
    // CheckoutDetailsProvider checkoutDetailsProviderData =
    //     Provider.of<CheckoutDetailsProvider>(context);

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

                  getSum(data);

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
                                        '₹${getSum(data)}',
                                        style: kTotalSumTextStyle2.copyWith(
                                            fontSize:
                                                _mediaQuery.size.height * 0.03),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //Checkout Button
                              TextButton(
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () {
                                  // deliveryAddressData.addressLine1.isEmpty ||
                                  //     deliveryAddressData
                                  //         .addressLine1.isEmpty ||
                                  //     deliveryAddressData.firstName.isEmpty ||
                                  //     deliveryAddressData.pincode
                                  //         .toString()
                                  //         .isEmpty
                                  // if (9) {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return Center(
                                  //           child: Container(
                                  //             height: 150,
                                  //             padding: EdgeInsets.all(20),
                                  //             width: _mediaQuery.size.width,
                                  //             color: Colors.white,
                                  //             child: Column(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Text(
                                  //                   'No Delivery address found',
                                  //                   style: kSemibold.copyWith(
                                  //                       fontSize: 15),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 30,
                                  //                 ),
                                  //                 GestureDetector(
                                  //                   onTap: () {
                                  //                     Navigator.of(context)
                                  //                         .pop();
                                  //                     Navigator.pushNamed(
                                  //                         context,
                                  //                         'deliveryAddressEdit');
                                  //                   },
                                  //                   child: Container(
                                  //                     decoration: BoxDecoration(
                                  //                       color: Colors
                                  //                           .grey.shade300,
                                  //                     ),
                                  //                     padding:
                                  //                         EdgeInsets.all(15),
                                  //                     child: Row(
                                  //                       children: [
                                  //                         Container(
                                  //                           padding:
                                  //                               EdgeInsets.only(
                                  //                                   right: 5,
                                  //                                   left: 5),
                                  //                           child:
                                  //                               Icon(Icons.add),
                                  //                         ),
                                  //                         Text(
                                  //                           'Add Delivery address',
                                  //                           style: kSemibold
                                  //                               .copyWith(
                                  //                                   fontSize:
                                  //                                       13),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         );
                                  //       });
                                  // } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutPage(
                                          //   email: checkoutDetailsProvider
                                          //       .userEmailID,
                                          //   phone:
                                          //       personalDetailsData.phoneNumber!,
                                          //   deliveryAddress: deliveryAddressData,
                                          //   shoppingList:
                                          //       shoppingCartProductsList,
                                          //   totalSum: getSum(data),
                                          //   productListDesc:
                                          //       checkoutDetailsProvider
                                          //           .getDescription(
                                          //               shoppingCartProductsList),
                                          //   generatedOrderID:
                                          //       checkoutDetailsProvider
                                          //           .generateOrderId(),
                                          //   personalDetails: personalDetailsData,
                                          //   checkoutDetailsProvider:
                                          //       checkoutDetailsProviderData,
                                          // ),
                                          ),
                                    ),
                                  );
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
                                    borderRadius: BorderRadius.circular(
                                        _mediaQuery.size.height * 0.5),
                                  ),
                                  // color: Colors.amber,
                                  child: Text(
                                    'Continue to Checkout',
                                    style: kAddToCartTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            _mediaQuery.size.height * 0.02),
                                  ),
                                ),
                              )
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

  num getSum(List<ShoppingCartProduct> data) {
    num sum = 0;
    for (ShoppingCartProduct item in data) {
      sum = sum + (item.price * item.quantity);
    }

    print(sum);
    return sum;
  }
}
