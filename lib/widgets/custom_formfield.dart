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
    this.obscureText = false,
    this.fillColor,
    this.hintTextSize,
    this.inputTextSize,
    this.errorTextSize,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final String initialText;
  MediaQueryData mediaQuery;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  bool obscureText = false;
  Color? fillColor = Colors.white;
  double? hintTextSize = 15;
  double? inputTextSize = 15;
  double? errorTextSize = 15;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      cursorColor: kColorCursorAuthPage,
      style: kInputFormFieldsAuthPage.copyWith(fontSize: inputTextSize),
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        errorStyle: kErrorFormFields.copyWith(fontSize: errorTextSize),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: kSemibold.copyWith(fontSize: hintTextSize).copyWith(
              color: Colors.black38,
            ),
      ),
    );
  }
}
