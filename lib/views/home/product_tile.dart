import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/overview/product_overview.dart';
import 'package:murpanara/widgets/HomePageWidgets/product_status_banner.dart';

class ProductTile extends StatefulWidget {
  const ProductTile({Key? key, required this.subProductList}) : super(key: key);

  final List<SubProducts> subProductList;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Container(
          color: kColorHomePageBg,
          height: _mediaQuery.size.height * 0.62,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: _mediaQuery.size.height * 0.01,
                );
              },
              itemCount: widget.subProductList.length,
              itemBuilder: (context, index) {
                var isWishlistedNew;

                return Container(
                  margin: EdgeInsets.only(
                      left: _mediaQuery.size.width * 0.04,
                      right: _mediaQuery.size.width * 0.04),
                  height: _mediaQuery.size.height * 0.4,
                  width: _mediaQuery.size.width,
                  decoration: BoxDecoration(
                    color: kColorProductTitleBg,
                    // color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.amber,
                        height: _mediaQuery.size.height * 0.35,
                        width: _mediaQuery.size.width,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Stack(
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductOverview(
                                          subproduct:
                                              widget.subProductList[index],
                                        ),
                                      ),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: Image.network(
                                      widget.subProductList[index].imagefront),
                                ),
                              ),

                              //Favourite Button
                              Container(
                                margin: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.1,
                                    right: constraints.maxWidth * 0.09),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    var itemCheck = await DatabaseServices()
                                        .checkItem(
                                            subproduct:
                                                widget.subProductList[index]);
                                    if (itemCheck == true) {
                                      await DatabaseServices()
                                          .deleteWishlistItemOnFirestore(
                                              subProducts:
                                                  widget.subProductList[index]);
                                      setState(() {
                                        isWishlistedNew = false;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              itemRemovedFromWishlistSnackBar);
                                    } else {
                                      await DatabaseServices()
                                          .setWishlistItemOnFirestore(
                                              subProducts:
                                                  widget.subProductList[index]);
                                      setState(() {
                                        isWishlistedNew = true;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              itemAddedToWishlistSnackBar);
                                    }
                                  },
                                  child: FutureBuilder(
                                    future: DatabaseServices().checkItem(
                                        subproduct:
                                            widget.subProductList[index]),
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        var isWishlisted = snapshot.data!;
                                        isWishlistedNew = isWishlisted;
                                        return isWishlistedNew
                                            ? Icon(
                                                Icons.favorite,
                                                size: _mediaQuery.size.height *
                                                    0.03,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                size: _mediaQuery.size.height *
                                                    0.03,
                                                color: Colors.black,
                                              );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                  ),
                                ),
                              ),

                              //Out of Stock
                              widget.subProductList[index].status != 'Available'
                                  ? ProductStatusBanner(
                                      txt: widget.subProductList[index].status,
                                      fontSize: _mediaQuery.size.height * 0.01,
                                      fontColor: Colors.white,
                                      bannerColor:
                                          widget.subProductList[index].status ==
                                                  'Arriving Soon'
                                              ? Colors.green.withOpacity(0.8)
                                              : Colors.red.withOpacity(0.8),
                                      borderRadiusGeometry:
                                          BorderRadius.circular(
                                              _mediaQuery.size.height * 0.006),
                                      margin: EdgeInsets.only(
                                          left: _mediaQuery.size.width * 0.025,
                                          top: _mediaQuery.size.height * 0.012),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              _mediaQuery.size.width * 0.025,
                                          vertical:
                                              _mediaQuery.size.height * 0.006),
                                    )
                                  : Container(),
                            ],
                          );
                        }),
                      ),
                      Text(
                        widget.subProductList[index].name,
                        style: kProductsTitlesTextStyle.copyWith(
                            fontSize: _mediaQuery.size.height * 0.02),
                      ),
                      Text(
                        '₹ ${widget.subProductList[index].price.toString()}.00',
                        style: kProductsTitlesTextStyle.copyWith(
                            fontSize: _mediaQuery.size.height * 0.017),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
