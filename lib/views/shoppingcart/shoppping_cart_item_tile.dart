import 'package:flutter/material.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/services/database_services.dart';

class ShoppingCartItemTile extends StatelessWidget {
  const ShoppingCartItemTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ShoppingCartProduct product;

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.04,
            right: _mediaQuery.size.width * 0.04,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(_mediaQuery.size.height * 0.02),
          ),
          padding: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.04,
            right: _mediaQuery.size.width * 0.04,
          ),
          height: _mediaQuery.size.height * 0.141,
          width: _mediaQuery.size.width * 0.36,
          child: Image.network(product.imagefront),
        ),
        Container(
          padding: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.03,
            right: _mediaQuery.size.width * 0.03,
            top: _mediaQuery.size.height * 0.015,
            bottom: _mediaQuery.size.width * 0.03,
          ),
          height: _mediaQuery.size.height * 0.141,
          width: _mediaQuery.size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: _mediaQuery.size.height * 0.028),
                child: FittedBox(
                  child: Text(
                    (product.name),
                    style: kShoppingCartItemTextStyle.copyWith(
                        fontSize: _mediaQuery.size.height * 0.022),
                  ),
                ),
              ),
              Text(
                'Price: ₹ ${product.price}.00',
                style: kShoppingCartSubTitlesTextStyle.copyWith(
                    fontSize: _mediaQuery.size.height * 0.018),
              ),
              Text(
                'Size: ${product.size}',
                style: kShoppingCartSubTitlesTextStyle.copyWith(
                    fontSize: _mediaQuery.size.height * 0.018),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _mediaQuery.size.height * 0.14,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await DatabaseServices().deleteShoppingCartItemOnFirestore(
                    shoppingCartProduct: product,
                  );

                  ScaffoldMessenger.of(context)
                      .showSnackBar(itemRemovedFromShoppingCartSnackBar);

                  debugPrint('deleted');
                  debugPrint('done');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: _mediaQuery.size.height * 0.035,
                  width: _mediaQuery.size.width * 0.055,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.black26,
                    size: _mediaQuery.size.height * 0.02,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.035),
                child: Text(
                  'x${product.quantity}',
                  style: kShoppingQuantityTextStyle.copyWith(
                      fontSize: _mediaQuery.size.height * 0.02),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
