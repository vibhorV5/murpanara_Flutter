import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class PersonalInfoField extends StatelessWidget {
  const PersonalInfoField(
      {Key? key, required this.titleField, required this.userTitleField})
      : super(key: key);

  final String titleField;
  final String userTitleField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2),
          child: Text(
            titleField,
            style: kSemibold.copyWith(fontSize: 13).copyWith(
                  color: Colors.black45,
                ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Text(
            userTitleField,
            style: kSemibold.copyWith(fontSize: 13, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
