import 'package:flutter/material.dart';
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
    return Scaffold(
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
          List<SubProducts> productsData = snapshot.data! as List<SubProducts>;
          print(productsData);
          return WishlistTile(
            subProductList: productsData,
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
