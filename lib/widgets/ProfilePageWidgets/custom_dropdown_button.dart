import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
    required this.txt,
    required this.listValues,
    this.readOnly = false,
    this.inputTextSize,
    this.errorTextSize,
  }) : super(key: key);

  final String? dropdownValue;
  final void Function(String?)? onChanged;
  final List<String> listValues;
  final String txt;
  final bool readOnly;
  double? inputTextSize = 15;
  double? errorTextSize = 15;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: kErrorFormFields.copyWith(fontSize: errorTextSize),
        border: const UnderlineInputBorder(borderSide: BorderSide.none),
      ),
      style: kInputFormFieldsAuthPage.copyWith(fontSize: inputTextSize),
      isExpanded: true,
      borderRadius: BorderRadius.circular(10),
      alignment: Alignment.centerRight,
      value: dropdownValue,
      onChanged: onChanged,
      validator: (value) => value == null ? txt : null,
      items: listValues.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
