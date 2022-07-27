import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/home/product_tile.dart';
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
    final _mediaQuery = MediaQuery.of(context);
    // final List<SubproductsMain> subproduct =
    //     Provider.of<List<SubproductsMain>>(context);

    return Scaffold(
      backgroundColor: kColorHomePageBg,
      body: StreamBuilder(
        stream: DatabaseServices().productsStream,
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
            List<Product> productsData = snapshot.data! as List<Product>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: _mediaQuery.size.height * 0.2,
                    width: _mediaQuery.size.width,
                    child: LayoutBuilder(
                      builder: (context, constrainsts) {
                        return Column(
                          children: [
                            //TITLE: Welcome to the dawn..
                            Container(
                              // color: Colors.green.withOpacity(0.2),
                              height: constrainsts.maxHeight * 0.5,
                              width: constrainsts.maxWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'WELCOME TO THE DAWN OF',
                                    style: kHomePageTitlesTextStyle.copyWith(
                                        fontSize:
                                            constrainsts.maxHeight * 0.11),
                                  ),
                                  Center(
                                    child: Text(
                                      'MURPANARA',
                                      style: kHomePageTitlesTextStyle.copyWith(
                                          fontSize:
                                              constrainsts.maxHeight * 0.12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //TITLE: You are now viewing..
                            Container(
                              // color: Colors.green.withOpacity(0.2),
                              height: constrainsts.maxHeight * 0.5,
                              width: constrainsts.maxWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'YOUR ARE NOW VIEWING OUR LATEST RELEASE',
                                    style: kHomePageTitlesTextStyle.copyWith(
                                        fontFamily: 'AvertaStd-Semibold',
                                        fontSize:
                                            constrainsts.maxHeight * 0.08),
                                  ),
                                  Center(
                                    child: Container(
                                      height: constrainsts.maxHeight * 0.22,
                                      child: Image.asset(
                                        'assets/images/mpr_eye.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    child: ProductTile(
                      subProductList: productsData.first.subproducts,
                    ),
                  ),
                  // SizedBox(
                  //   height: 100,
                  // )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Some db error'),
            );
          }
        },
      ),
    );
  }
}
