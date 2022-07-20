import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/india_states.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:murpanara/widgets/cancel_button.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/disabled_formfield.dart';
import 'package:murpanara/widgets/custom_dropdown_button.dart';
import 'package:murpanara/widgets/headings_title.dart';
import 'package:murpanara/widgets/save_button.dart';
import 'package:murpanara/widgets/title_field_text.dart';
import 'package:murpanara/widgets/top_heading.dart';
import 'package:provider/provider.dart';

class BillingAddressEdit extends StatefulWidget {
  const BillingAddressEdit({Key? key}) : super(key: key);

  @override
  State<BillingAddressEdit> createState() => _BillingAddressEditState();
}

class _BillingAddressEditState extends State<BillingAddressEdit> {
  @override
  void dispose() {
    print('dispose');
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    pincodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    // BillingAddress billingAddressData = Provider.of<BillingAddress>(context);

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
                child: TopHeading(txt: 'Billing Address'),
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
                      HeadingsTitle(titleText: 'Billing Address'),
                      TitleFieldText(titleFieldText: '*Address line 1'),
                      CustomFormField(
                        initialText: 'billingAddressData.addressLine1',
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
                        height: 13,
                      ),

                      TitleFieldText(titleFieldText: 'Address line 2'),
                      CustomFormField(
                        initialText: 'billingAddressData.addressLine2',
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
                        height: 13,
                      ),

                      TitleFieldText(titleFieldText: 'Pin code'),

                      CustomFormField(
                        initialText: '',
                        // initialText: UserMethods.checkNumField(
                        //     billingAddressData.pincode!),
                        onChanged: (val) {
                          pincodeController.text = val;
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 6) {
                            return 'Please enter a valid pincode';
                          }
                          return null;
                        },
                        textController: pincodeController,
                        mediaQuery: _mediaQuery,
                        hintText: 'Enter your postcode. E.g. 122003',
                      ),

                      SizedBox(
                        height: 13,
                      ),

                      TitleFieldText(titleFieldText: '*City'),

                      CustomFormField(
                        initialText: 'billingAddressData.city',
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
                        height: 13,
                      ),

                      //State
                      TitleFieldText(titleFieldText: '*State'),

                      CustomDropDownButton(
                          listValues: kListIndianStates,
                          txt: 'Please select a state',
                          dropdownValue: dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              stateController.text = value!;
                              dropdownValue = value;
                            });
                          }),

                      SizedBox(
                        height: 13,
                      ),

                      //Country
                      TitleFieldText(titleFieldText: '*Country'),

                      DisabledFormField(
                        txt: 'India',
                      ),

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
                    // await DatabaseServices().setBillingAddress(
                    //   billingAddress: BillingAddress(
                    //     addressLine1: addressLine1Controller.text,
                    //     addressLine2: addressLine2Controller.text,
                    //     pincode: num.tryParse(pincodeController.text),
                    //     city: cityController.text,
                    //     state: stateController.text,
                    //   ),
                    // );
                    print('billing address set');
                    print('done baby');
                    Navigator.of(context).pop();
                  } else {
                    print('fuck you failed');
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
