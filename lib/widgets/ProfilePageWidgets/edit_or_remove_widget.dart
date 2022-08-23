import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class EditOrRemoveWidget extends StatelessWidget {
  const EditOrRemoveWidget({
    Key? key,
    required this.label,
    this.icon,
    required this.fontSize,
  }) : super(key: key);

  final String label;
  final Icon? icon;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kSemibold.copyWith(
            fontSize: fontSize,
          ),
        ),
        Container(
          child: icon,
        ),
      ],
    );
  }
}
