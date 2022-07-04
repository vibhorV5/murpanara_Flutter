import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/providers/quantity_provider.dart';
import 'package:murpanara/providers/size_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductOverview extends StatefulWidget {
  ProductOverview({Key? key, required this.subproduct}) : super(key: key);

  SubProducts subproduct;

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    //State Providers
    var sizeState = Provider.of<SizeProvider>(context);
    var quantityState = Provider.of<QuantityProvider>(context);

    final _mediaQuery = MediaQuery.of(context);

    List sizes = widget.subproduct.size;

    var isWishlistedNew;

    List<Widget> imagesPro = [
      //1st Image of Slider
      Container(
        // color: Colors.pink,
        height: _mediaQuery.size.height * 0.5,
        width: _mediaQuery.size.width,
        // margin: EdgeInsets.all(6.0),
        child: Image.network(widget.subproduct.imagefront),
      ),

      //2nd Image of Slider
      Container(
        // color: Colors.purple,
        height: _mediaQuery.size.height * 0.5,
        width: _mediaQuery.size.width,
        // margin: EdgeInsets.all(6.0),
        child: Image.network(widget.subproduct.imageback),
      ),
    ];

    void _showBottomPanel({required SubProducts subProducts}) {
      showModalBottomSheet(
          backgroundColor: Colors.black.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(_mediaQuery.size.height * 0.03),
            ),
          ),
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: ((context, setModalState) {
              return Container(
                height: _mediaQuery.size.height * 0.355,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_mediaQuery.size.height * 0.03),
                    topRight: Radius.circular(_mediaQuery.size.height * 0.03),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: _mediaQuery.size.height * 0.02),
                      child: Text(
                        'Select Quantity',
                        style: kSemibold.copyWith(
                            color: Colors.white,
                            fontSize: _mediaQuery.size.height * 0.033),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setModalState(() {
                              quantityState.decreaseQuantity();
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: _mediaQuery.size.height * 0.055,
                            width: _mediaQuery.size.height * 0.055,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Text('-',
                                style: kSemibold.copyWith(
                                    color: Colors.white,
                                    fontSize: _mediaQuery.size.height * 0.05)),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.all(_mediaQuery.size.height * 0.03),
                          child: Text('${quantityState.getQuantity}',
                              style: kSemibold.copyWith(
                                  color: Colors.white,
                                  fontSize: _mediaQuery.size.height * 0.03)),
                        ),
                        InkWell(
                          onTap: () {
                            setModalState(() {
                              quantityState.increaseQuantity();
                            });
                          },
                          child: Container(
                            height: _mediaQuery.size.height * 0.055,
                            width: _mediaQuery.size.height * 0.055,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: Text('+',
                                style: kSemibold.copyWith(
                                    color: Colors.white,
                                    fontSize: _mediaQuery.size.height * 0.05)),
                          ),
                        ),
                      ],
                    ),

                    //Confirm Button
                    GestureDetector(
                      onTap: () async {
                        bool result = await DatabaseServices()
                            .checkShoppingCartItem(
                                subproduct: widget.subproduct,
                                quantity: quantityState.getQuantity,
                                size: sizeState.sizeSelected);
                        if (result == false) {
                          await DatabaseServices().setShoppingCartItem(
                              subProducts: subProducts,
                              productSize: sizeState.sizeSelected,
                              productQuantity: quantityState.getQuantity);

                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(successSnackBar);
                          print('Item added to shopping cart');
                          setState(() {
                            sizeState.setSize('');
                            quantityState.setQuantity(1);
                          });
                        } else {
                          Navigator.of(context).pop();
                          print('already present');
                          ScaffoldMessenger.of(context)
                              .showSnackBar(itemAlreadyPresentSnackBar);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: _mediaQuery.size.height * 0.04,
                        width: _mediaQuery.size.width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.5),
                        ),
                        margin: EdgeInsets.only(
                            top: _mediaQuery.size.height * 0.03),
                        child: Text(
                          'Confirm',
                          style: kAddToCartTextStyle.copyWith(
                              fontSize: _mediaQuery.size.height * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(30),
              );
            }));
          });
    }

    Widget buildIndicator() {
      return AnimatedSmoothIndicator(
          effect: WormEffect(
            activeDotColor: Colors.black54,
            dotHeight: _mediaQuery.size.height * 0.011,
            dotWidth: _mediaQuery.size.height * 0.011,
          ),
          activeIndex: activeIndex,
          count: imagesPro.length);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  //Product
                  Container(
                    decoration: BoxDecoration(
                      color: kColorProductTitleBg,
                      borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(_mediaQuery.size.height * 0.08),
                        bottomRight:
                            Radius.circular(_mediaQuery.size.height * 0.08),
                      ),
                    ),
                    width: _mediaQuery.size.width,
                    height: _mediaQuery.size.height * 0.43,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CarouselSlider(
                          items: imagesPro,
                          options: CarouselOptions(
                              height: _mediaQuery.size.height * 0.42,
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: _mediaQuery.size.height * 0.38),
                    // color: Colors.amber,
                    alignment: Alignment.bottomCenter,
                    child: buildIndicator(),
                  ),

                  //Back Arrow
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: _mediaQuery.size.height * 0.015,
                          left: _mediaQuery.size.width * 0.025),

                      // color: Colors.blueAccent,
                      child: Icon(Icons.arrow_back_ios_new_outlined,
                          size: _mediaQuery.size.width * 0.065,
                          color: kColorBackIconForgotPassPage),
                    ),
                  ),
                ],
              ),

              //MPR Eye logo
              Container(
                // color: Colors.amber.withOpacity(0.4),
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.018),
                height: _mediaQuery.size.height * 0.045,
                width: _mediaQuery.size.width * 0.15,
                child: Image.asset('assets/images/mpr_eye.png'),
              ),

              //Product Title
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                // color: Colors.amberAccent,
                child: Text(
                  widget.subproduct.name,
                  style: kProductsOverviewTitlesTextStyle.copyWith(
                    fontSize: _mediaQuery.size.height * 0.03,
                  ),
                ),
              ),

              //Product Price
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.002),
                // color: Colors.purple.withOpacity(0.4),
                child: Text(
                  '₹ ${widget.subproduct.price.toString()}.00',
                  style: kProductsTitlesTextStyle.copyWith(
                    fontSize: _mediaQuery.size.height * 0.027,
                  ),
                ),
              ),

              //Size(title)
              Container(
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.035),
                alignment: Alignment.centerLeft,
                // color: Colors.blue,
                child: Text(
                  'Size',
                  style: kProductsInfoTitles.copyWith(
                      fontSize: _mediaQuery.size.height * 0.02),
                ),
              ),

              //Sizes Buttons
              SizeButtons(
                sizeList: sizes,
                mediaQ: _mediaQuery,
              ),

              //Description(Title)
              Container(
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.035),
                alignment: Alignment.centerLeft,
                // color: Colors.blue,
                child: Text(
                  'Description',
                  style: kProductsInfoTitles.copyWith(
                      fontSize: _mediaQuery.size.height * 0.02),
                ),
              ),

              //Description Details

              //Fit
              Container(
                // color: Colors.yellow.withOpacity(0.3),
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.012),
                width: _mediaQuery.size.width,
                // height: _mediaQuery.size.height * 0.07,
                child: Text(
                  'Fit Type : ${widget.subproduct.fit}',
                  style: kProductsDescTitles.copyWith(
                      fontSize: _mediaQuery.size.height * 0.016),
                ),
              ),

              //Composition
              Container(
                // color: Colors.red.withOpacity(0.3),
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.007),
                width: _mediaQuery.size.width,
                // height: _mediaQuery.size.height * 0.07,
                child: Text(
                  'Composition : ${widget.subproduct.composition}',
                  style: kProductsDescTitles.copyWith(
                      fontSize: _mediaQuery.size.height * 0.016),
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Wishlisted Icon
                    GestureDetector(
                      onTap: () async {
                        var itemCheck = await DatabaseServices()
                            .checkItem(subproduct: widget.subproduct);
                        if (itemCheck == true) {
                          await DatabaseServices()
                              .deleteWishlistItemOnFirestore(
                                  subProducts: widget.subproduct);
                          setState(() {
                            isWishlistedNew = false;
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(itemRemovedFromWishlistSnackBar);

                          print('item removed from wishlist');
                        } else {
                          await DatabaseServices().setWishlistItemOnFirestore(
                              subProducts: widget.subproduct);
                          setState(() {
                            isWishlistedNew = true;
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(itemAddedToWishlistSnackBar);

                          print('Added added to wishlist');
                        }
                      },
                      child: FutureBuilder(
                        future: DatabaseServices()
                            .checkItem(subproduct: widget.subproduct),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            var isWishlisted = snapshot.data!;
                            isWishlistedNew = isWishlisted;
                            return isWishlistedNew
                                ? Container(
                                    alignment: Alignment.center,
                                    height: _mediaQuery.size.height * 0.07,
                                    width: _mediaQuery.size.width * 0.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      color: Color(0xFFF6F6F6),
                                      borderRadius: BorderRadius.circular(
                                          _mediaQuery.size.height * 0.01),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      size: _mediaQuery.size.height * 0.024,
                                      color: Colors.red,
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: _mediaQuery.size.height * 0.07,
                                    width: _mediaQuery.size.width * 0.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      color: Color(0xFFF6F6F6),
                                      borderRadius: BorderRadius.circular(
                                          _mediaQuery.size.height * 0.01),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: _mediaQuery.size.height * 0.024,
                                      color: Colors.black,
                                    ),
                                  );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              height: _mediaQuery.size.height * 0.07,
                              width: _mediaQuery.size.width * 0.14,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(
                                    _mediaQuery.size.height * 0.01),
                              ),
                              child: Icon(
                                Icons.favorite_border_outlined,
                                size: _mediaQuery.size.height * 0.024,
                                color: Colors.black,
                              ),
                            );
                          }
                        }),
                      ),
                    ),

                    SizedBox(
                      width: _mediaQuery.size.width * 0.025,
                    ),

                    //Add to Cart
                    TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        if (sizeState.sizeSelected != '') {
                          _showBottomPanel(subProducts: widget.subproduct);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(errorSnackBar);
                        }
                      },
                      child: Container(
                        child: Text(
                          'Add to Cart',
                          style: kAddToCartTextStyle.copyWith(
                              fontSize: _mediaQuery.size.height * 0.02),
                        ),
                        alignment: Alignment.center,
                        height: _mediaQuery.size.height * 0.07,
                        width: _mediaQuery.size.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.5),
                        ),
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

class SizeButtons extends StatefulWidget {
  SizeButtons({
    Key? key,
    required this.mediaQ,
    required this.sizeList,
  }) : super(key: key);

  final MediaQueryData mediaQ;
  List sizeList;
  String selectedS = '';

  @override
  State<SizeButtons> createState() => _SizeButtonsState();
}

class _SizeButtonsState extends State<SizeButtons> {
  @override
  Widget build(BuildContext context) {
    var sizeState = Provider.of<SizeProvider>(context);

    return Container(
      margin: EdgeInsets.only(
          left: widget.mediaQ.size.width * 0.055,
          top: widget.mediaQ.size.height * 0.012),
      width: widget.mediaQ.size.width,
      height: widget.mediaQ.size.height * 0.08,
      // color: Colors.yellow.withOpacity(0.3),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: widget.mediaQ.size.width * 0.025,
          );
        },
        itemCount: widget.sizeList.length,
        itemBuilder: ((context, index) {
          Container getContainer;

          if (sizeState.getSizeSelected == widget.sizeList[index]) {
            getContainer = Container(
              alignment: Alignment.center,
              height: widget.mediaQ.size.height * 0.07,
              width: widget.mediaQ.size.width * 0.14,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.circular(widget.mediaQ.size.height * 0.01),
              ),
              child: Text(
                widget.sizeList[index],
                style: kProductsSizesTextStyle.copyWith(
                    color: Color(0xFFF6F6F6),
                    fontFamily: 'AvertaStd-Semibold',
                    fontSize: widget.mediaQ.size.height * 0.028),
              ),
            );
          } else {
            getContainer = Container(
              alignment: Alignment.center,
              height: widget.mediaQ.size.height * 0.07,
              width: widget.mediaQ.size.width * 0.14,
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius:
                    BorderRadius.circular(widget.mediaQ.size.height * 0.01),
              ),
              child: Text(
                widget.sizeList[index],
                style: kProductsSizesTextStyle.copyWith(
                    color: Colors.black,
                    fontFamily: 'AvertaStd-Semibold',
                    fontSize: widget.mediaQ.size.height * 0.028),
              ),
            );
          }

          return GestureDetector(
              onTap: () {
                sizeState.setSize(widget.sizeList[index]);

                print('${sizeState.getSizeSelected} size slected');
              },
              child: getContainer);
        }),
      ),
    );
  }
}
