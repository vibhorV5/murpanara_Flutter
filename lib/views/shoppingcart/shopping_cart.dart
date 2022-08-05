import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
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
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);
    CheckoutDetailsProvider checkoutDetailsProvider =
        Provider.of<CheckoutDetailsProvider>(context);
    List<ShoppingCartProduct> shoppingCartProductsList =
        Provider.of<List<ShoppingCartProduct>>(context);
    CheckoutDetailsProvider checkoutDetailsProviderData =
        Provider.of<CheckoutDetailsProvider>(context);

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: kColorShoppingCartPageBg,
      body: Column(children: [
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

        shoppingCartProductsList.isEmpty
            ? Container(
                alignment: Alignment.center,
                height: _mediaQuery.size.height * 0.6,
                width: _mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.black.withOpacity(0.8),
                      size: _mediaQuery.size.height * 0.12,
                    ),

                    Container(
                      margin:
                          EdgeInsets.only(top: _mediaQuery.size.height * 0.02),
                      child: Text(
                        'Your Shopping Cart is empty.',
                        style: kSemibold.copyWith(
                          fontSize: _mediaQuery.size.height * 0.027,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
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
                            vertical: _mediaQuery.size.height * 0.014),
                        child: Text(
                          'Continue Shopping',
                          style: kSemibold.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: _mediaQuery.size.height < 600
                        ? _mediaQuery.size.height * 0.38
                        : _mediaQuery.size.height * 0.45,
                    width: _mediaQuery.size.width,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ShoppingCartItemTile(
                              product: shoppingCartProductsList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: _mediaQuery.size.height * 0.025,
                          );
                        },
                        itemCount: shoppingCartProductsList.length),
                  ),
                  Container(
                    height: _mediaQuery.size.height * 0.1,
                    margin: EdgeInsets.only(
                        left: _mediaQuery.size.width * 0.04,
                        right: _mediaQuery.size.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: kTotalSumTextStyle.copyWith(
                              fontSize: _mediaQuery.size.height * 0.03),
                        ),
                        Text(
                          '₹${getSum(shoppingCartProductsList)}',
                          style: kTotalSumTextStyle2.copyWith(
                              fontSize: _mediaQuery.size.height * 0.03),
                        ),
                      ],
                    ),
                  ),

                  //Checkout Button
                  TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      if (deliveryAddressData.addressLine1.isEmpty ||
                          deliveryAddressData.addressLine1.isEmpty ||
                          deliveryAddressData.firstName.isEmpty ||
                          deliveryAddressData.pincode.toString().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      _mediaQuery.size.height * 0.028),
                                  color: Colors.white,
                                ),
                                height: _mediaQuery.size.height * 0.2,
                                margin: EdgeInsets.symmetric(
                                  horizontal: _mediaQuery.size.height * 0.015,
                                ),
                                padding: EdgeInsets.all(
                                    _mediaQuery.size.height * 0.02),
                                width: _mediaQuery.size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'No Delivery address found',
                                      style: kSemibold.copyWith(
                                          fontSize:
                                              _mediaQuery.size.height * 0.02),
                                    ),
                                    SizedBox(
                                      height: _mediaQuery.size.height * 0.05,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(
                                            context, 'deliveryAddressEdit');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        ),
                                        padding: EdgeInsets.all(
                                            _mediaQuery.size.height * 0.015),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      _mediaQuery.size.width *
                                                          0.02),
                                              child: const Icon(Icons.add),
                                            ),
                                            Text(
                                              'Add Delivery Address',
                                              style: kSemibold.copyWith(
                                                  fontSize:
                                                      _mediaQuery.size.height *
                                                          0.015),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                              email: checkoutDetailsProvider.userEmailID,
                              deliveryAddress: deliveryAddressData,
                              shoppingList: shoppingCartProductsList,
                              totalSum: getSum(shoppingCartProductsList),
                              productListDesc: checkoutDetailsProvider
                                  .getDescription(shoppingCartProductsList),
                              generatedOrderID:
                                  checkoutDetailsProvider.generateOrderId(),
                              checkoutDetailsProvider:
                                  checkoutDetailsProviderData,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: _mediaQuery.size.height * 0.02,
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
                      child: Text(
                        'Continue to Checkout',
                        style: kAddToCartTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: _mediaQuery.size.height * 0.02),
                      ),
                    ),
                  )
                ],
              )
      ]),
    );
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
