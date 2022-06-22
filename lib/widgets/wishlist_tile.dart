import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/overview/product_overview.dart';

class WishlistTile extends StatefulWidget {
  WishlistTile({Key? key, required this.subProductList}) : super(key: key);

  List<SubProducts> subProductList;

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final String uid = AuthService().currentUser!.uid;

    return Container(
      color: Colors.white,
      height: _mediaQuery.size.height * 0.69,
      child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: _mediaQuery.size.height * 0.01,
            );
          },
          itemCount: widget.subProductList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: _mediaQuery.size.width * 0.04,
                  right: _mediaQuery.size.width * 0.04),
              height: _mediaQuery.size.height * 0.2,
              width: _mediaQuery.size.width,
              decoration: BoxDecoration(
                color: Color(0xFFF6F6F6),
                // color: Colors.red,
                borderRadius:
                    BorderRadius.circular(_mediaQuery.size.width * 0.04),
              ),
              child: Column(
                children: [
                  Container(
                    // color: Colors.red,
                    height: _mediaQuery.size.height * 0.15,
                    width: _mediaQuery.size.width,
                    child: LayoutBuilder(
                      builder: ((context, constraints) {
                        return Stack(
                          children: [
                            Center(
                              child: Container(
                                // color: Colors.blue,

                                //Product Image
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductOverview(
                                                subproduct: widget
                                                    .subProductList[index],
                                              )),
                                    ).then((value) => setState(() {}));
                                  },
                                  child: Image.network(
                                      widget.subProductList[index].imagefront),
                                ),
                              ),
                            ),

                            //Delete Button
                            Container(
                              margin: EdgeInsets.only(
                                  top: constraints.maxHeight * 0.1,
                                  right: constraints.maxWidth * 0.04),
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () async {
                                  await DatabaseServices()
                                      .deleteWishlistItemOnFirestore(
                                          subProducts:
                                              widget.subProductList[index]);

                                  print('deleted');
                                  print('done');
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: _mediaQuery.size.height * 0.028,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),

                  Text(
                    widget.subProductList[index].name,
                    style: kProductsTitlesTextStyle.copyWith(
                        fontSize: _mediaQuery.size.height * 0.017),
                  ),
                  Text(
                    '₹ ${widget.subProductList[index].price.toString()}.00',
                    style: kProductsTitlesTextStyle.copyWith(
                        fontSize: _mediaQuery.size.height * 0.015),
                  ),
                  // Text(widget.subProductList[index].fit),
                  // Text(widget.subProductList[index].composition),
                ],
              ),
            );
          }),
    );
  }
}
