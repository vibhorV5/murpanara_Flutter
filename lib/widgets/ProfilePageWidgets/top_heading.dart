import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class TopHeading extends StatelessWidget {
  const TopHeading({
    Key? key,
    required this.txt,
    required this.fontSize,
    required this.margin,
  }) : super(key: key);

  final String txt;
  final double fontSize;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: fontSize),
      ),
    );
  }
}
