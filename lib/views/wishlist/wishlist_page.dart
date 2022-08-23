import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/views/wishlist/wishlist_tile.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final List<SubProducts> wishlistProductsData =
        Provider.of<List<SubProducts>>(context);

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: kColorWishlistPageBg,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: _mediaQuery.size.height * 0.04,
              bottom: _mediaQuery.size.height * 0.025,
              left: _mediaQuery.size.width * 0.04,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Wishlist',
              style: kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
            ),
          ),
          wishlistProductsData.isEmpty
              ? SizedBox(
                  height: _mediaQuery.size.height * 0.6,
                  width: _mediaQuery.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.heart_broken_rounded,
                        color: Colors.black.withOpacity(0.8),
                        size: _mediaQuery.size.height * 0.12,
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
                                fontSize: _mediaQuery.size.height * 0.018,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
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
                  subProductList: wishlistProductsData,
                ),
        ],
      ),
    );
  }
}
