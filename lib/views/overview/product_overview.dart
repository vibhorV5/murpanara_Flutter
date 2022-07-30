import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/providers/quantity_provider.dart';
import 'package:murpanara/providers/size_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:murpanara/widgets/HomePageWidgets/product_status_banner.dart';
import 'package:murpanara/widgets/ProductOverviewWidgets/custom_addtocart_button.dart';
import 'package:murpanara/widgets/ProductOverviewWidgets/custom_confirm_button.dart';
import 'package:murpanara/widgets/ProductOverviewWidgets/custom_fav_botton.dart';
import 'package:murpanara/widgets/ProductOverviewWidgets/size_selector_buttons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({Key? key, required this.subproduct}) : super(key: key);

  final SubProducts subproduct;

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
      SizedBox(
        // color: Colors.pink,
        height: _mediaQuery.size.height * 0.5,
        width: _mediaQuery.size.width,
        // margin: EdgeInsets.all(6.0),
        child: Image.network(widget.subproduct.imagefront),
      ),

      //2nd Image of Slider
      SizedBox(
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
          return StatefulBuilder(
            builder: ((context, setModalState) {
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
                            decoration: const BoxDecoration(
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
                            decoration: const BoxDecoration(
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
                    CustomConfirmButtom(
                        mediaQuery: _mediaQuery,
                        onTapFunction: () async {
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
                        }),
                  ],
                ),
                // padding: EdgeInsets.all(_mediaQuery.size.height * 0.1),
              );
            }),
          );
        },
      );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.subproduct.status != 'Available'
                          ? ProductStatusBanner(
                              txt: widget.subproduct.status,
                              fontSize: _mediaQuery.size.height * 0.01,
                              fontColor: Colors.white,
                              bannerColor:
                                  widget.subproduct.status == 'Arriving Soon'
                                      ? Colors.green.withOpacity(0.8)
                                      : Colors.red.withOpacity(0.8),
                              borderRadiusGeometry: BorderRadius.circular(
                                  _mediaQuery.size.height * 0.006),
                              margin: EdgeInsets.only(
                                  left: _mediaQuery.size.width * 0.025,
                                  right: _mediaQuery.size.width * 0.025,
                                  top: _mediaQuery.size.height * 0.012),
                              padding: EdgeInsets.symmetric(
                                  horizontal: _mediaQuery.size.width * 0.025,
                                  vertical: _mediaQuery.size.height * 0.006),
                            )
                          : Container(),
                    ],
                  )
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
              SizeSelectorButtons(
                productStatus: widget.subproduct.status,
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
                                ? CustomFavButton(
                                    containerWidth:
                                        _mediaQuery.size.width * 0.14,
                                    containerHeight:
                                        _mediaQuery.size.height * 0.07,
                                    icon: Icon(
                                      Icons.favorite,
                                      size: _mediaQuery.size.height * 0.024,
                                      color: Colors.red,
                                    ),
                                    borderRadiusGeometry: BorderRadius.circular(
                                        _mediaQuery.size.height * 0.01),
                                  )
                                : CustomFavButton(
                                    containerWidth:
                                        _mediaQuery.size.width * 0.14,
                                    containerHeight:
                                        _mediaQuery.size.height * 0.07,
                                    icon: Icon(
                                      Icons.favorite_border_outlined,
                                      size: _mediaQuery.size.height * 0.024,
                                      color: Colors.black,
                                    ),
                                    borderRadiusGeometry: BorderRadius.circular(
                                        _mediaQuery.size.height * 0.01),
                                  );
                          } else {
                            return CustomFavButton(
                              containerWidth: _mediaQuery.size.width * 0.14,
                              containerHeight: _mediaQuery.size.height * 0.07,
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                size: _mediaQuery.size.height * 0.024,
                                color: Colors.black,
                              ),
                              borderRadiusGeometry: BorderRadius.circular(
                                  _mediaQuery.size.height * 0.01),
                            );
                          }
                        }),
                      ),
                    ),

                    SizedBox(
                      width: _mediaQuery.size.width * 0.025,
                    ),

                    //Add to Cart
                    widget.subproduct.status != 'Available'
                        ? CustomAddToCartButton(
                            onPress: () {},
                            mediaQuery: _mediaQuery,
                            txt: widget.subproduct.status.toUpperCase(),
                            buttonColor: Colors.grey,
                          )
                        : CustomAddToCartButton(
                            buttonColor: Colors.black,
                            txt: 'Add to Cart',
                            mediaQuery: _mediaQuery,
                            onPress: () {
                              if (sizeState.sizeSelected != '') {
                                _showBottomPanel(
                                    subProducts: widget.subproduct);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(errorSnackBar);
                              }
                            })
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
