import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.textController,
    required this.mediaQuery,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.onChanged,
    required this.initialText,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final String initialText;
  MediaQueryData mediaQuery;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorColor: kColorCursorAuthPage,
      style: kInputFormFieldsAuthPage.copyWith(fontSize: 14),
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        errorStyle: kErrorFormFields,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: kSemibold.copyWith(fontSize: 10).copyWith(
              color: Colors.black38,
            ),
      ),
    );
  }
}
