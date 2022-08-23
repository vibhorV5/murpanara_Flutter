import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

class DisabledFormField extends StatelessWidget {
  DisabledFormField({
    Key? key,
    required this.txt,
    this.initalTextSize,
  }) : super(key: key);

  final String txt;
  double? initalTextSize = 14;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      initialValue: txt,
      keyboardType: TextInputType.number,
      cursorColor: kColorCursorAuthPage,
      style: kInputFormFieldsAuthPage.copyWith(fontSize: initalTextSize),
      // textAlignVertical: TextAlignVertical.center,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        errorStyle: kErrorFormFields,
        border: InputBorder.none,
      ),
    );
  }
}
