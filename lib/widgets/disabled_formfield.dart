import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

class DisabledFormField extends StatelessWidget {
  const DisabledFormField({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      initialValue: txt,
      keyboardType: TextInputType.number,
      cursorColor: kColorCursorAuthPage,
      style: kInputFormFieldsAuthPage.copyWith(fontSize: 14),
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        errorStyle: kErrorFormFields,
        border: InputBorder.none,
      ),
    );
  }
}
