import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

class DateSelector extends StatelessWidget {
  DateSelector({
    Key? key,
    required this.dateController,
    this.errorTextSize,
  }) : super(key: key);

  final TextEditingController dateController;
  double? errorTextSize = 15;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: dateController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: kColorCursorAuthPage,
      style: kInputFormFieldsAuthPage.copyWith(fontSize: 14),
      // textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        errorStyle: kErrorFormFields.copyWith(fontSize: errorTextSize),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        dateController.text = value;
      },
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1920),
          lastDate: DateTime(2023),
          errorFormatText: '',
          errorInvalidText: '',
        ).then((selectedDate) {
          if (selectedDate != null) {
            dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
    );
  }
}
