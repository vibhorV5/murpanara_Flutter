import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _mediaQuery = MediaQuery.of(context);

    TextEditingController nameController = TextEditingController();

    return Scaffold(
      // backgroundColor: Colors.white,
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
        child: Container(
          margin: EdgeInsets.only(
              top: _mediaQuery.size.height * 0.04,
              left: _mediaQuery.size.width * 0.04,
              right: _mediaQuery.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi Member',
                  style:
                      kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.04),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.purple,
                ),
                height: _mediaQuery.size.height * 0.5,
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.01),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(_mediaQuery.size.width * 0.04),
                  color: Colors.orange,
                ),
                height: _mediaQuery.size.height * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
      required this.textController,
      required this.mediaQuery,
      required this.hintText,
      required this.validatorText})
      : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final String validatorText;
  MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.size.height * 0.05,
      margin: EdgeInsets.only(
        right: mediaQuery.size.width * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mediaQuery.size.height * 0.08),
        color: kColorFormFieldsAuthPage,
      ),
      child: Center(
        child: TextFormField(
          validator: (value) => value!.isEmpty ? validatorText : null,
          onChanged: (val) {
            textController.text = val;
          },
          keyboardType: TextInputType.emailAddress,
          cursorColor: kColorCursorAuthPage,
          style: kInputFormFieldsAuthPage,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            errorStyle: kErrorFormFields,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: kHintStyleFormFields.copyWith(
                fontSize: mediaQuery.size.height * 0.02),
          ),
        ),
      ),
    );
  }
}
