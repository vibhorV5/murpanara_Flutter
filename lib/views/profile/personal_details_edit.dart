import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:intl/intl.dart';

class PersonalDetailsEdit extends StatefulWidget {
  const PersonalDetailsEdit({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsEdit> createState() => _PersonalDetailsEditState();
}

class _PersonalDetailsEditState extends State<PersonalDetailsEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? dropdownValue = 'Male';

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
                        textController: firstNameController,
                        mediaQuery: _mediaQuery,
                        hintText: '',
                        validatorText: 'Please enter a first name',
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      TitleFieldText(titleFieldText: '*Last name'),
                      CustomFormField(
                        textController: lastNameController,
                        mediaQuery: _mediaQuery,
                        hintText: '',
                        validatorText: 'Please enter a last name',
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      TitleFieldText(titleFieldText: '*Date of birth'),

                      //DOB form field
                      Container(
                        height: _mediaQuery.size.height * 0.05,
                        width: _mediaQuery.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.08),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              readOnly: true,
                              controller: dateController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: kColorCursorAuthPage,
                              style: kInputFormFieldsAuthPage.copyWith(
                                  fontSize: 14),
                              // textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                errorStyle: kErrorFormFields,
                                border: InputBorder.none,
                              ),
                              onTap: () async {
                                await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime(2023),
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    dateController.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                  }
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a date';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      // //Phone number
                      TitleFieldText(titleFieldText: '*Phone number'),

                      Container(
                        height: _mediaQuery.size.height * 0.05,
                        width: _mediaQuery.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.08),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              initialValue: '+91 ',
                              keyboardType: TextInputType.number,
                              cursorColor: kColorCursorAuthPage,
                              style: kInputFormFieldsAuthPage.copyWith(
                                  fontSize: 14),
                              // textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                errorStyle: kErrorFormFields,
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                phoneNumberController.text = val;
                              },

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10) {
                                  return 'Please enter a 10 digit Phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      // //Gender
                      TitleFieldText(titleFieldText: '*Gender'),

                      Container(
                        height: _mediaQuery.size.height * 0.05,
                        width: _mediaQuery.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.08),
                          color: Colors.white,
                        ),
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                              style: kInputFormFieldsAuthPage.copyWith(
                                  fontSize: 14),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              alignment: Alignment.centerRight,
                              value: dropdownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              items: <String>[
                                'Male',
                                'Female',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            // validator: (value) {
                            //   if (value == null ||
                            //       value.isEmpty ||
                            //       value.length < 10) {
                            //     return 'Please enter a 10 digit Phone number.';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      // //Postal Code
                      TitleFieldText(titleFieldText: '*Postal Code'),

                      Container(
                        height: _mediaQuery.size.height * 0.05,
                        width: _mediaQuery.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.08),
                          color: Colors.grey[400],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              enabled: false,
                              initialValue: '250001',
                              keyboardType: TextInputType.number,
                              cursorColor: kColorCursorAuthPage,
                              style: kInputFormFieldsAuthPage.copyWith(
                                  fontSize: 14),
                              // textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                errorStyle: kErrorFormFields,
                                border: InputBorder.none,
                              ),

                              // validator: (value) {
                              //   if (value == null ||
                              //       value.isEmpty ||
                              //       value.length < 10) {
                              //     return 'Please enter a 10 digit Phone number.';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                      ),

                      SmallInfoText(
                          txt:
                              'You can edit your Postal Code under Address Book.'),

                      SizedBox(
                        height: 13,
                      ),

                      // //Country
                      TitleFieldText(titleFieldText: '*Country'),

                      Container(
                        height: _mediaQuery.size.height * 0.05,
                        width: _mediaQuery.size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              _mediaQuery.size.height * 0.08),
                          color: Colors.grey[400],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: TextFormField(
                              enabled: false,
                              initialValue: 'India',
                              keyboardType: TextInputType.number,
                              cursorColor: kColorCursorAuthPage,
                              style: kInputFormFieldsAuthPage.copyWith(
                                  fontSize: 14),
                              // textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                errorStyle: kErrorFormFields,
                                border: InputBorder.none,
                              ),

                              // validator: (value) {
                              //   if (value == null ||
                              //       value.isEmpty ||
                              //       value.length < 10) {
                              //     return 'Please enter a 10 digit Phone number.';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 13,
                      ),
                    ],
                  ),
                ),
              ),
              SaveButton(
                  formKey: _formKey,
                  mediaQuery: _mediaQuery,
                  txt: 'Save details',
                  color: Colors.black,
                  txtColor: Colors.white),
              SaveButton(
                  formKey: _formKey,
                  mediaQuery: _mediaQuery,
                  txt: 'Cancel',
                  color: Colors.grey.shade200,
                  txtColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}

class SmallInfoText extends StatelessWidget {
  const SmallInfoText({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2, top: 5),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 10).copyWith(
              color: Colors.black45,
            ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  SaveButton({
    Key? key,
    required this.mediaQuery,
    required this.txt,
    required this.color,
    required this.txtColor,
    required this.formKey,
  }) : super(key: key);

  final MediaQueryData mediaQuery;
  final String txt;
  final Color color;
  final Color txtColor;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () async {
        FocusScope.of(context).unfocus();
        if (formKey.currentState!.validate()) {
          print('valid');
        } else {
          FocusScope.of(context).unfocus();
          print('invalid');
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            // top: _mediaQuery.size.height * 0.01,
            // bottom: _mediaQuery.size.height * 0.02,
            ),
        alignment: Alignment.center,
        height: mediaQuery.size.height * 0.06,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.4),
        ),
        // color: Colors.amber,
        child: Text(
          txt,
          style: kAddToCartTextStyle.copyWith(
              color: txtColor, fontSize: mediaQuery.size.height * 0.02),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.textController,
    required this.mediaQuery,
    required this.hintText,
    required this.validatorText,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final String validatorText;
  MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.size.height * 0.05,
      margin: EdgeInsets.only(
          // right: mediaQuery.size.width * 0.04,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.08),
        color: Colors.white,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            validator: (value) => value!.isEmpty ? validatorText : null,
            onChanged: (val) {
              textController.text = val;
            },
            keyboardType: TextInputType.emailAddress,
            cursorColor: kColorCursorAuthPage,
            style: kInputFormFieldsAuthPage.copyWith(fontSize: 14),
            // textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorStyle: kErrorFormFields,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: kHintStyleFormFields.copyWith(
                  fontSize: mediaQuery.size.height * 0.02),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleFieldText extends StatelessWidget {
  const TitleFieldText({
    Key? key,
    required this.titleFieldText,
  }) : super(key: key);

  final String titleFieldText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Text(
        titleFieldText,
        style: kSemibold.copyWith(fontSize: 13).copyWith(
              color: Colors.black87,
            ),
      ),
    );
  }
}

class TopHeading extends StatelessWidget {
  const TopHeading({
    Key? key,
    required this.txt,
  }) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 30),
      child: Text(
        txt,
        style: kSemibold.copyWith(fontSize: 22),
      ),
    );
  }
}

class HeadingsTitle extends StatelessWidget {
  const HeadingsTitle({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        titleText,
        style: kSemibold.copyWith(fontSize: 15),
      ),
    );
  }
}
