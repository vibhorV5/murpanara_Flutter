import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class SmallInfoText extends StatelessWidget {
  const SmallInfoText({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2, top: 5),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 10).copyWith(
              color: Colors.black45,
            ),
      ),
    );
  }
}
