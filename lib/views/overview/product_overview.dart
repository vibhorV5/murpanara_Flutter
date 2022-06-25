import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductOverview extends StatefulWidget {
  ProductOverview({Key? key, required this.subproduct}) : super(key: key);

  SubProducts subproduct;

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  @override
  int activeIndex = 0;

  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    var isWishlistedNew;

    String selectedSize = '';
    num selectedQuantity = 0;

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

    void _showBottomPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Row(
                children: [
                  Text('Select Quantity'),
                  GestureDetector(
                    onTap: () {
                      selectedQuantity = 1;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.red.withOpacity(0.4),
                          padding: EdgeInsets.all(20),
                          child: Text('1')),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedQuantity = 3;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.red.withOpacity(0.4),
                        padding: EdgeInsets.all(20),
                        child: Text('3'),
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(30),
            );
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
              Container(
                margin: EdgeInsets.only(
                    left: _mediaQuery.size.width * 0.055,
                    top: _mediaQuery.size.height * 0.012),
                width: _mediaQuery.size.width,
                height: _mediaQuery.size.height * 0.08,
                // color: Colors.yellow.withOpacity(0.3),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: _mediaQuery.size.width * 0.025,
                    );
                  },
                  itemCount: widget.subproduct.size.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedSize = widget.subproduct.size[index];
                        print('$selectedSize size slected');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: _mediaQuery.size.height * 0.07,
                        width: _mediaQuery.size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.01),
                        ),
                        child: Text(
                          widget.subproduct.size[index],
                          style: kProductsSizesTextStyle.copyWith(
                              fontFamily: 'AvertaStd-Semibold',
                              fontSize: _mediaQuery.size.height * 0.028),
                        ),
                      ),
                    );
                  }),
                ),
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
                        } else {
                          await DatabaseServices().setWishlistItemOnFirestore(
                              subProducts: widget.subproduct);
                          setState(() {
                            isWishlistedNew = true;
                          });
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
                              return Container();
                            }
                          })),
                    ),

                    SizedBox(
                      width: _mediaQuery.size.width * 0.025,
                    ),

                    //Add to Cart
                    TextButton(
                      onPressed: () async {
                        _showBottomPanel();
                        if (selectedSize != '' && selectedQuantity != 0) {
                          await DatabaseServices().setShoppingCartItem(
                              subProducts: widget.subproduct,
                              productSize: selectedSize,
                              productQuantity: selectedQuantity);
                          print('Item added to shopping cart');
                          setState(() {
                            selectedSize = '';
                            selectedQuantity = 0;
                          });
                        } else {
                          print('please select a size');
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
