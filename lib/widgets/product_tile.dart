import 'package:flutter/material.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/views/overview/product_overview.dart';

class ProductTile extends StatefulWidget {
  ProductTile({Key? key, required this.subProductList}) : super(key: key);

  List<SubProducts> subProductList;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    final String uid = AuthService().currentUser!.uid;

    return Container(
      height: 600,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: widget.subProductList.length,
          itemBuilder: (context, index) {
            var isWishlistedNew;
            return Container(
              color: Colors.black.withOpacity(0.4),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80.0),
                    child: Row(
                      children: [
                        Container(
                          // color: Colors.red,
                          height: 200,
                          width: 300,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductOverview(
                                              subproduct:
                                                  widget.subProductList[index],
                                            )),
                                  ).then((value) => setState(() {}));
                                },
                                child: Image.network(
                                    widget.subProductList[index].imagefront),
                              ),
                              GestureDetector(
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
                                  } else {
                                    await DatabaseServices()
                                        .setWishlistItemOnFirestore(
                                            subProducts:
                                                widget.subProductList[index]);
                                    setState(() {
                                      isWishlistedNew = true;
                                    });
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
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.black,
                                              );
                                      } else {
                                        return Container();
                                      }
                                    })),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(widget.subProductList[index].name),
                  Text(widget.subProductList[index].price.toString()),
                  Text(widget.subProductList[index].fit),
                  Text(widget.subProductList[index].composition),
                ],
              ),
            );
          }),
    );
  }
}
