import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/cancel_button.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/date_selector.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/disabled_formfield.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/custom_dropdown_button.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/small_info_text.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/title_field_text.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/top_heading.dart';
import 'package:provider/provider.dart';

class PersonalDetailsEdit extends StatefulWidget {
  const PersonalDetailsEdit({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsEdit> createState() => _PersonalDetailsEditState();
}

class _PersonalDetailsEditState extends State<PersonalDetailsEdit> {
  @override
  void dispose() {
    debugPrint('dispose');
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
    DeliveryAddress deliveryAddressData = Provider.of<DeliveryAddress>(context);

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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 0.1,
            onPressed: () {},
            icon: const Icon(
              Icons.settings_rounded,
              size: 0.1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TopHeading(
                    margin: EdgeInsets.symmetric(
                        vertical: _mediaQuery.size.height * 0.033),
                    fontSize: _mediaQuery.size.height * 0.028,
                    txt: 'Personal details'),
              ),
              Container(
                width: _mediaQuery.size.width,
                padding: EdgeInsets.all(_mediaQuery.size.width * 0.03),
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
                      HeadingsTitle(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.03),
                          fontSize: _mediaQuery.size.height * 0.019,
                          titleText: 'Personal details'),
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*First name'),
                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
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
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Last name'),
                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
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
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Date of birth'),

                      //DOB form field
                      DateSelector(
                          initalTextSize: _mediaQuery.size.height * 0.015,
                          errorTextSize: _mediaQuery.size.height * 0.013,
                          dateController: dateController),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      // //Phone number
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Phone number'),

                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
                        textController: phoneNumberController,
                        mediaQuery: _mediaQuery,
                        hintText: '10 digit Phone number',
                        validator: (value) {
                          if (value!.isEmpty ||
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
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      // //Gender
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Gender'),

                      CustomDropDownButton(
                          inputTextSize: _mediaQuery.size.height * 0.015,
                          errorTextSize: _mediaQuery.size.height * 0.013,
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
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      // //Postal Code
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Postal Code'),

                      DisabledFormField(
                        initalTextSize: _mediaQuery.size.height * 0.015,
                        txt: UserMethods.checkNumField(
                            deliveryAddressData.pincode!),
                      ),

                      SmallInfoText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.002,
                              top: _mediaQuery.size.height * 0.009),
                          fontSize: _mediaQuery.size.height * 0.012,
                          txt:
                              'You can edit your Postal Code under Address Book'),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      // //Country
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Country'),

                      DisabledFormField(
                          initalTextSize: _mediaQuery.size.height * 0.015,
                          txt: 'India'),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),
                    ],
                  ),
                ),
              ),
              SaveButton(
                fontSize: _mediaQuery.size.height * 0.02,
                height: _mediaQuery.size.height * 0.056,
                borderRadiusGeometry:
                    BorderRadius.circular(_mediaQuery.size.height * 0.04),
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
                    debugPrint('Successfully set personal details');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(personalDetailsSavedSnackbar);

                    Navigator.of(context).pop();
                  } else {
                    debugPrint('No personal details set');
                  }
                },
                mediaQuery: _mediaQuery,
                txt: 'Save',
                color: Colors.black,
                txtColor: Colors.white,
              ),
              CancelButton(
                fontSize: _mediaQuery.size.height * 0.02,
                height: _mediaQuery.size.height * 0.056,
                borderRadiusGeometry:
                    BorderRadius.circular(_mediaQuery.size.height * 0.04),
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
