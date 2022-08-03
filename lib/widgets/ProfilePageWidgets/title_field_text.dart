import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class TitleFieldText extends StatelessWidget {
  const TitleFieldText({
    Key? key,
    required this.titleFieldText,
    required this.margin,
    required this.fontSize,
  }) : super(key: key);

  final String titleFieldText;
  final EdgeInsetsGeometry? margin;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        titleFieldText,
        style: kSemibold.copyWith(fontSize: fontSize).copyWith(
              color: Colors.black87,
            ),
      ),
    );
  }
}
