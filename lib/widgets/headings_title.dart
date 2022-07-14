import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class HeadingsTitle extends StatelessWidget {
  const HeadingsTitle({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        titleText,
        style: kSemibold.copyWith(fontSize: 15),
      ),
    );
  }
}
