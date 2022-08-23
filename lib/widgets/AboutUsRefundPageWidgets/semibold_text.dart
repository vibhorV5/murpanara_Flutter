import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SemiBoldText extends StatelessWidget {
  const SemiBoldText({
    Key? key,
    required this.txt,
    required this.fontSize,
  }) : super(key: key);

  final String txt;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: kSemibold.copyWith(fontSize: fontSize),
    );
  }
}
