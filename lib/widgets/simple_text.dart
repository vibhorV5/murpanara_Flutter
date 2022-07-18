import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({
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
        style: kRegular.copyWith(fontSize: 13),
      ),
    );
  }
}
