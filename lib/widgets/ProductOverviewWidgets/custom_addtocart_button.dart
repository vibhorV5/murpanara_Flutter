import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class CustomAddToCartButton extends StatelessWidget {
  const CustomAddToCartButton({
    Key? key,
    required this.onPress,
    required this.mediaQuery,
    required this.txt,
    required this.buttonColor,
  }) : super(key: key);

  final void Function()? onPress;
  final MediaQueryData mediaQuery;
  final String txt;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPress,
      child: Container(
        child: Text(
          txt,
          style: kAddToCartTextStyle.copyWith(
              fontSize: mediaQuery.size.height * 0.02, color: Colors.white),
        ),
        alignment: Alignment.center,
        height: mediaQuery.size.height * 0.07,
        width: mediaQuery.size.width * 0.7,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.5),
        ),
      ),
    );
  }
}
