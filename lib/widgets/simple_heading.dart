import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SimpleHeading extends StatelessWidget {
  const SimpleHeading({
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
        style: kSemibold.copyWith(fontSize: 20),
      ),
    );
  }
}
