import 'package:flutter/material.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/product_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Product> product = Provider.of<List<Product>>(context);
    // final List<SubproductsMain> subproduct =
    //     Provider.of<List<SubproductsMain>>(context);

    return Scaffold(
        body: StreamBuilder(
      stream: DatabaseServices().productsStream,
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
          List<Product> productsData = snapshot.data! as List<Product>;
          return ProductTile(
            subProductList: productsData.first.subproducts,
          );
        } else {
          return Center(
            child: Text('Some db error'),
          );
        }
      },
    ));
    // final List<SubProducts> subProducts = product.subproducts;
    // List<SubProducts> subProductsData = [];

    // if (product != null) {
    //   product.forEach((element) {
    //     print(element.name);
    //     subProductsData = element.subproducts;
    //   });
    // }

    // return Scaffold(
    //     body: Container(
    //   color: Colors.red.withOpacity(0.2),
    //   width: 400,
    //   height: 600,
    //   child: Column(
    //     children: [
    //       Container(child: Text(subproduct[0].name)),
    //     ],
    //   ),
    // ));
  }
}
