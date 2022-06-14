import 'package:flutter/material.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/services/database_services.dart';

class ProductOverview extends StatefulWidget {
  ProductOverview({Key? key, required this.subproduct}) : super(key: key);

  SubProducts subproduct;

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  @override
  Widget build(BuildContext context) {
    var isWishlistedNew;
    String selectedSize = '';
    num selectedQuantity = 0;

    void _showBottomPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Row(
                children: [
                  Text('Select Quantity'),
                  GestureDetector(
                    onTap: () {
                      selectedQuantity = 1;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.red.withOpacity(0.4),
                          padding: EdgeInsets.all(20),
                          child: Text('1')),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedQuantity = 3;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.red.withOpacity(0.4),
                          padding: EdgeInsets.all(20),
                          child: Text('3')),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(30),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(onTap: () {}, child: Icon(Icons.back_hand)),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              color: Colors.blue.withOpacity(0.3),
              height: 500,
              width: 500,
              child: Image.network(widget.subproduct.imagefront),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Wishlisted Icon
              GestureDetector(
                onTap: () async {
                  var itemCheck = await DatabaseServices()
                      .checkItem(subproduct: widget.subproduct);
                  if (itemCheck == true) {
                    await DatabaseServices().deleteWishlistItemOnFirestore(
                        subProducts: widget.subproduct);
                    setState(() {
                      isWishlistedNew = false;
                    });
                  } else {
                    await DatabaseServices().setWishlistItemOnFirestore(
                        subProducts: widget.subproduct);
                    setState(() {
                      isWishlistedNew = true;
                    });
                  }
                },
                child: FutureBuilder(
                    future: DatabaseServices()
                        .checkItem(subproduct: widget.subproduct),
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

              //Select Size
              Container(
                height: 160,
                width: 90,
                color: Colors.yellow.withOpacity(0.3),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: widget.subproduct.size.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedSize = widget.subproduct.size[index];
                        print('$selectedSize size slected');
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        color: Colors.pink.withOpacity(0.2),
                        child: Text(widget.subproduct.size[index]),
                      ),
                    );
                  }),
                ),
              ),
              //Add to Cart
              Container(
                child: TextButton(
                  onPressed: () async {
                    _showBottomPanel();
                    if (selectedSize != '' && selectedQuantity != 0) {
                      await DatabaseServices().setShoppingCartItem(
                          subProducts: widget.subproduct,
                          productSize: selectedSize,
                          productQuantity: selectedQuantity);
                      print('Item added to shopping cart');
                      setState(() {
                        selectedSize = '';
                        selectedQuantity = 0;
                      });
                    } else {
                      print('please select a size');
                    }
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
