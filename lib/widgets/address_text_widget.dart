import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class AddressTextWidget extends StatelessWidget {
  AddressTextWidget({
    Key? key,
    required this.txt,
    this.fontSize,
  }) : super(key: key);

  final String txt;
  double? fontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: kSemibold.copyWith(
        fontSize: fontSize,
      ),
    );
  }
}
