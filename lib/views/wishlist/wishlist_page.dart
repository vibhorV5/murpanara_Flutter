import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/wishlist_tile.dart';

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
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Has Error'),
              );
            } else if (snapshot.hasData) {
              List<SubProducts> productsData =
                  snapshot.data! as List<SubProducts>;
              print(productsData);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: _mediaQuery.size.height * 0.04,
                          bottom: _mediaQuery.size.height * 0.03,
                          left: _mediaQuery.size.width * 0.04),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Wishlist',
                        style: kWishlistTitleTextStyle.copyWith(
                            fontSize: _mediaQuery.size.height * 0.05),
                      ),
                    ),
                    WishlistTile(
                      subProductList: productsData,
                    ),
                  ],
                ),
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
