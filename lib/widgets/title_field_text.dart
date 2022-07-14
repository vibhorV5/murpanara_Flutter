import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class TitleFieldText extends StatelessWidget {
  const TitleFieldText({
    Key? key,
    required this.titleFieldText,
  }) : super(key: key);

  final String titleFieldText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Text(
        titleFieldText,
        style: kSemibold.copyWith(fontSize: 13).copyWith(
              color: Colors.black87,
            ),
      ),
    );
  }
}
