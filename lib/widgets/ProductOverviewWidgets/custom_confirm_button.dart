import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class CustomConfirmButtom extends StatelessWidget {
  const CustomConfirmButtom(
      {Key? key, required this.onTapFunction, required this.mediaQuery})
      : super(key: key);

  final void Function()? onTapFunction;
  final MediaQueryData mediaQuery;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        alignment: Alignment.center,
        height: mediaQuery.size.height * 0.04,
        width: mediaQuery.size.width * 0.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
          borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.5),
        ),
        margin: EdgeInsets.only(top: mediaQuery.size.height * 0.03),
        child: Text(
          'Confirm',
          style: kAddToCartTextStyle.copyWith(
              fontSize: mediaQuery.size.height * 0.02),
        ),
      ),
    );
  }
}
