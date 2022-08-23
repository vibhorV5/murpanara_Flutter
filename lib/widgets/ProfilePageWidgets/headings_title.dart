import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class HeadingsTitle extends StatelessWidget {
  const HeadingsTitle({
    Key? key,
    required this.titleText,
    required this.margin,
    required this.fontSize,
  }) : super(key: key);

  final String titleText;
  final double fontSize;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        titleText,
        style: kSemibold.copyWith(fontSize: fontSize),
      ),
    );
  }
}
