import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class CancelButton extends StatelessWidget {
  CancelButton({
    Key? key,
    required this.mediaQuery,
    required this.txt,
    required this.color,
    required this.txtColor,
    required this.ctx,
    required this.onPress,
    this.fontSize,
    this.borderRadiusGeometry,
    this.height,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final String txt;
  final Color color;
  final Color txtColor;
  final BuildContext ctx;
  void Function()? onPress;
  double? fontSize = 12;
  double? height = 40;
  BorderRadiusGeometry? borderRadiusGeometry = BorderRadius.circular(30);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPress,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadiusGeometry,
        ),
        // color: Colors.amber,
        child: Text(
          txt,
          style:
              kAddToCartTextStyle.copyWith(color: txtColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
