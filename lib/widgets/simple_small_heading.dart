import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SimpleSmallHeading extends StatelessWidget {
  const SimpleSmallHeading({
    Key? key,
    required this.txt,
  }) : super(
          key: key,
        );

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 14),
      ),
    );
  }
}
