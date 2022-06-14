import 'package:flutter/material.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/services/database_services.dart';

class WishlistTile extends StatefulWidget {
  WishlistTile({Key? key, required this.subProductList}) : super(key: key);

  List<SubProducts> subProductList;

  @override
  State<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends State<WishlistTile> {
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
                                .deleteWishlistItemOnFirestore(
                                    subProducts: widget.subProductList[index]);

                            print('deleted');
                            print('done');
                          },
                          icon: Icon(Icons.delete),
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
