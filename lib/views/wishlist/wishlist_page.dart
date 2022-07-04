import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/wishlist/wishlist_tile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: kColorWishlistPageBg,
        body: StreamBuilder(
          stream: DatabaseServices().wishlistSubproductsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Has Error'),
              );
            } else if (snapshot.hasData) {
              List<SubProducts> productsData =
                  snapshot.data! as List<SubProducts>;
              print(productsData);
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: _mediaQuery.size.height * 0.04,
                        bottom: _mediaQuery.size.height * 0.03,
                        left: _mediaQuery.size.width * 0.04),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Wishlist',
                      style: kBold.copyWith(
                          fontSize: _mediaQuery.size.height * 0.05),
                    ),
                  ),
                  productsData.isEmpty
                      ? Container(
                          // color: Colors.amber,
                          height: _mediaQuery.size.height * 0.6,
                          width: _mediaQuery.size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 100),
                                // height: _mediaQuery.size.height * 0.2,
                                child: Icon(
                                  Icons.heart_broken_rounded,
                                  color: Colors.black.withOpacity(0.8),
                                  size: _mediaQuery.size.height * 0.12,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: _mediaQuery.size.height * 0.02),
                                child: Text(
                                  'Your Wishlist is currently empty.',
                                  style: kSemibold.copyWith(
                                    fontSize: _mediaQuery.size.height * 0.027,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: _mediaQuery.size.height * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Try adding items to your wishlist by tapping ',
                                      style: kRegular.copyWith(
                                        fontSize:
                                            _mediaQuery.size.height * 0.018,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                    Container(
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.red,
                                        size: _mediaQuery.size.height * 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : WishlistTile(
                          subProductList: productsData,
                        ),
                ],
              );
            } else {
              return Center(
                child: Text('Some db error'),
              );
            }
          },
        ));
  }
}
