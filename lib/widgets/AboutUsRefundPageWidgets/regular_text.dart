import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class RegularText extends StatelessWidget {
  const RegularText({
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
      style: kRegular.copyWith(fontSize: fontSize),
    );
  }
}
