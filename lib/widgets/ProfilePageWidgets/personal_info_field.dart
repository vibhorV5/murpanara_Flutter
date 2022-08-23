import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class PersonalInfoField extends StatelessWidget {
  PersonalInfoField({
    Key? key,
    required this.headingText,
    required this.userInfoText,
    this.headingTextSize,
    this.userInfoTextSize,
    this.sizedBoxHeight,
  }) : super(key: key);

  final String headingText;
  final String userInfoText;

  double? headingTextSize = 13;
  double? userInfoTextSize = 13;
  double? sizedBoxHeight = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Heading title
        Text(
          headingText,
          style: kSemibold.copyWith(fontSize: headingTextSize).copyWith(
                color: Colors.black45,
              ),
        ),

        SizedBox(
          height: sizedBoxHeight,
        ),

        //Fetched info

        Text(
          userInfoText,
          style: kSemibold.copyWith(
              fontSize: userInfoTextSize, color: Colors.black),
        ),
      ],
    );
  }
}
