import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/cancel_button.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/date_selector.dart';
import 'package:murpanara/widgets/disabled_formfield.dart';
import 'package:murpanara/widgets/custom_dropdown_button.dart';
import 'package:murpanara/widgets/headings_title.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/small_info_text.dart';
import 'package:murpanara/widgets/title_field_text.dart';
import 'package:murpanara/widgets/top_heading.dart';

class PersonalDetailsEdit extends StatefulWidget {
  const PersonalDetailsEdit({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsEdit> createState() => _PersonalDetailsEditState();
}

class _PersonalDetailsEditState extends State<PersonalDetailsEdit> {
  @override
  void dispose() {
    print('dispose');
    firstNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String? dropdownValue;

  List<String> genders = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: _mediaQuery.size.width * 0.065,
            color: kColorBackIconForgotPassPage,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Container(
          // color: Colors.red,
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),

        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 0.1,
            onPressed: () {
              // Navigator.of(context).pushNamed('settingsPage');
            },
            icon: Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TopHeading(txt: 'Personal details'),
              ),
              Container(
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(
                    top: _mediaQuery.size.height * 0.02,
                    bottom: _mediaQuery.size.height * 0.02),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.grey.shade200,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingsTitle(titleText: 'Personal details'),
                      TitleFieldText(titleFieldText: '*First name'),
                      CustomFormField(
                        onChanged: (val) {
                          firstNameController.text = val;
                        },
                        keyboardType: TextInputType.name,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a first name' : null,
                        textController: firstNameController,
                        mediaQuery: _mediaQuery,
                        hintText: '',
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      TitleFieldText(titleFieldText: '*Last name'),
                      CustomFormField(
                        onChanged: (val) {
                          lastNameController.text = val;
                        },
                        keyboardType: TextInputType.name,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a last name' : null,
                        textController: lastNameController,
                        mediaQuery: _mediaQuery,
                        hintText: '',
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      TitleFieldText(titleFieldText: '*Date of birth'),

                      //DOB form field
                      DateSelector(dateController: dateController),

                      SizedBox(
                        height: 13,
                      ),

                      // //Phone number
                      TitleFieldText(titleFieldText: '*Phone number'),

                      CustomFormField(
                        textController: phoneNumberController,
                        mediaQuery: _mediaQuery,
                        hintText: '10 digit Phone number',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 10 ||
                              !(RegExp(r'(^[0-9])').hasMatch(value))) {
                            return 'Please enter a 10 digit Phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          phoneNumberController.text = val;
                        },
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      // //Gender
                      TitleFieldText(titleFieldText: '*Gender'),

                      CustomDropDownButton(
                          listValues: genders,
                          txt: 'Please select a gender',
                          dropdownValue: dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              genderController.text = value!;
                              dropdownValue = value;
                            });
                          }),

                      SizedBox(
                        height: 13,
                      ),

                      // //Postal Code
                      TitleFieldText(titleFieldText: '*Postal Code'),

                      DisabledFormField(txt: '250001'),

                      SmallInfoText(
                          txt:
                              'You can edit your Postal Code under Address Book.'),

                      SizedBox(
                        height: 13,
                      ),

                      // //Country
                      TitleFieldText(titleFieldText: '*Country'),

                      DisabledFormField(txt: 'India'),

                      SizedBox(
                        height: 13,
                      ),
                    ],
                  ),
                ),
              ),
              SaveButton(
                onPress: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    await DatabaseServices().setPersonalDetails(
                      personalDetails: PersonalDetails(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        dob: dateController.text,
                        gender: genderController.text,
                        phoneNumber: num.tryParse(phoneNumberController.text),
                      ),
                    );
                    print('successfully set personal details');
                    Navigator.of(context).pop();
                  } else {
                    print('fuck you no personal details set');
                  }
                },
                mediaQuery: _mediaQuery,
                txt: 'Save',
                color: Colors.black,
                txtColor: Colors.white,
              ),
              CancelButton(
                onPress: () {
                  Navigator.of(context).pop();
                },
                mediaQuery: _mediaQuery,
                txt: 'Cancel',
                color: Colors.grey.shade200,
                txtColor: Colors.black,
                ctx: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
