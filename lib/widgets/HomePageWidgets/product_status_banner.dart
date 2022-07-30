import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class ProductStatusBanner extends StatelessWidget {
  const ProductStatusBanner({
    Key? key,
    required this.txt,
    required this.fontSize,
    required this.fontColor,
    required this.bannerColor,
    required this.borderRadiusGeometry,
    required this.margin,
    required this.padding,
  }) : super(key: key);

  final String txt;
  final double fontSize;
  final Color fontColor;
  final Color bannerColor;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: bannerColor,
        borderRadius: borderRadiusGeometry,
      ),
      child: Text(
        txt,
        style: kSemibold.copyWith(
          fontSize: fontSize,
          color: fontColor,
        ),
      ),
    );
  }
}
