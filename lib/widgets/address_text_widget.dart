import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class AddressTextWidget extends StatelessWidget {
  const AddressTextWidget({
    Key? key,
    required this.txt,
    required MediaQueryData mediaQuery,
  })  : _mediaQuery = mediaQuery,
        super(key: key);

  final String txt;
  final MediaQueryData _mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: kSemibold.copyWith(
        fontSize: _mediaQuery.size.height * 0.014,
      ),
    );
  }
}
