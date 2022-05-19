import 'package:flutter/material.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/services/database_services.dart';

class ProductTile extends StatefulWidget {
  ProductTile({Key? key, required this.subProductList}) : super(key: key);

  List<SubProducts> subProductList;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final String uid = AuthService().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: widget.subProductList.length,
          itemBuilder: (context, index) {
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
                          width: 200,
                          child: Image.network(
                              widget.subProductList[index].imagefront),
                        ),
                        IconButton(
                          onPressed: () async {
                            await DatabaseServices()
                                .setWishlistItemOnFirestore();
                            print('done');
                            print('hello');
                          },
                          icon: Icon(Icons.favorite_border_rounded),
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
