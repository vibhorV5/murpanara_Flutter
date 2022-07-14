import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class TopHeading extends StatelessWidget {
  const TopHeading({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 30),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 22),
      ),
    );
  }
}
