import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/india_states.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/cancel_button.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/disabled_formfield.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/custom_dropdown_button.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/headings_title.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/title_field_text.dart';
import 'package:murpanara/widgets/ProfilePageWidgets/top_heading.dart';

class DeliveryAddressEdit extends StatefulWidget {
  const DeliveryAddressEdit({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressEdit> createState() => _DeliveryAddressEditState();
}

class _DeliveryAddressEditState extends State<DeliveryAddressEdit> {
  @override
  void dispose() {
    debugPrint('dispose');
    firstNameController.dispose();
    lastNameController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    pincodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? dropdownValue;

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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox(
          // color: Colors.red,
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
                    txt: 'Delivery Address'),
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
                          titleText: 'Delivery Address'),

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
                          titleFieldText: '*Address line 1'),
                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
                        onChanged: (val) {
                          addressLine1Controller.text = val;
                        },
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a Flat No. / House name'
                            : null,
                        textController: addressLine1Controller,
                        mediaQuery: _mediaQuery,
                        hintText: 'Flat No. / House name',
                      ),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Address line 2'),
                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
                        onChanged: (val) {
                          addressLine2Controller.text = val;
                        },
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a Street address'
                            : null,
                        textController: addressLine2Controller,
                        mediaQuery: _mediaQuery,
                        hintText: 'Street address',
                      ),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*Pin code'),

                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
                        onChanged: (val) {
                          pincodeController.text = val;
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty || value.length != 6) {
                            return 'Please enter a valid pincode';
                          }
                          return null;
                        },
                        textController: pincodeController,
                        mediaQuery: _mediaQuery,
                        hintText: 'Enter your postcode. E.g. 122003',
                      ),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*City'),

                      CustomFormField(
                        fillColor: Colors.white,
                        hintTextSize: _mediaQuery.size.height * 0.014,
                        inputTextSize: _mediaQuery.size.height * 0.015,
                        errorTextSize: _mediaQuery.size.height * 0.013,
                        initialText: '',
                        onChanged: (val) {
                          cityController.text = val;
                        },
                        keyboardType: TextInputType.name,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a City/town' : null,
                        textController: cityController,
                        mediaQuery: _mediaQuery,
                        hintText: 'City/town',
                      ),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      //State
                      TitleFieldText(
                          margin: EdgeInsets.only(
                              bottom: _mediaQuery.size.height * 0.001),
                          fontSize: _mediaQuery.size.height * 0.015,
                          titleFieldText: '*State'),

                      CustomDropDownButton(
                          inputTextSize: _mediaQuery.size.height * 0.015,
                          errorTextSize: _mediaQuery.size.height * 0.013,
                          txt: 'Please select a state',
                          listValues: kListIndianStates,
                          dropdownValue: dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              stateController.text = value!;
                              dropdownValue = value;
                            });
                          }),

                      SizedBox(
                        height: _mediaQuery.size.height * 0.021,
                      ),

                      //Country
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
                    await DatabaseServices().setDeliveryAddress(
                      deliveryAddress: DeliveryAddress(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          addressLine1: addressLine1Controller.text,
                          addressLine2: addressLine2Controller.text,
                          pincode: num.tryParse(pincodeController.text),
                          city: cityController.text,
                          state: stateController.text,
                          phone: num.tryParse(phoneNumberController.text)),
                    );
                    debugPrint('delivery address set');
                    debugPrint('Delivery Address set Success');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(deliveryAddressSavedSnackbar);

                    Navigator.of(context).pop();
                  } else {
                    debugPrint('Delivery Address set failed');
                  }
                },
                mediaQuery: _mediaQuery,
                txt: 'Save',
                color: Colors.black,
                txtColor: Colors.white,
              ),
              CancelButton(
                borderRadiusGeometry:
                    BorderRadius.circular(_mediaQuery.size.height * 0.04),
                fontSize: _mediaQuery.size.height * 0.02,
                height: _mediaQuery.size.height * 0.056,
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
