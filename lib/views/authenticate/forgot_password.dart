import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/methods/user_methods.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/big_image_widget.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/save_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void dispose() {
    super.dispose();
    emailController;
  }

  String error = '';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigImageWidget(
                height: _mediaQuery.size.height * 0.28,
                width: _mediaQuery.size.width,
                imageUrl: 'assets/images/mpr_main.png',
              ),

              //Blank space
              SizedBox(height: _mediaQuery.size.height * 0.14),

              //Reset Password Text
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: _mediaQuery.size.width * 0.05),
                child: Text(
                  'Reset Password',
                  style:
                      kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
                ),
              ),

              //Fields
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Email Id Field
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _mediaQuery.size.width * 0.05,
                          vertical: _mediaQuery.size.height * 0.012),
                      // color: Colors.black,
                      child: CustomFormField(
                          inputTextSize: _mediaQuery.size.height * 0.017,
                          fillColor: Colors.grey.shade100,
                          textController: emailController,
                          mediaQuery: _mediaQuery,
                          hintText: 'Email Id',
                          validator: (value) => value!.isEmpty
                              ? 'Enter Registered Email Id'
                              : null,
                          onChanged: (val) {
                            emailController.text = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialText: ''),
                    ),

                    // Request Password Reset Button
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _mediaQuery.size.width * 0.05,
                          vertical: _mediaQuery.size.height * 0.012),
                      child: SaveButton(
                        fontSize: _mediaQuery.size.height * 0.02,
                        height: _mediaQuery.size.height * 0.056,
                        borderRadiusGeometry: BorderRadius.circular(
                            _mediaQuery.size.height * 0.04),
                        mediaQuery: _mediaQuery,
                        txt: 'Request Password Reset',
                        color: Colors.black,
                        txtColor: Colors.white,
                        onPress: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await AuthService()
                                .resetPassword(email: emailController);

                            if (result == null) {
                              UserMethods.customDialogBoxOneButton(
                                borderRadius: _mediaQuery.size.width * 0.06,
                                contentPadding: _mediaQuery.size.width * 0.04,
                                contentContainerHeight:
                                    _mediaQuery.size.height * 0.28,
                                headingTextTopMargin:
                                    _mediaQuery.size.height * 0.02,
                                headingTextFontSize:
                                    _mediaQuery.size.height * 0.025,
                                confirmTextSize:
                                    _mediaQuery.size.height * 0.018,
                                cancelTextSize: _mediaQuery.size.height * 0.018,
                                subTextSize: _mediaQuery.size.height * 0.018,
                                mprEyeContainerHeight:
                                    _mediaQuery.size.width * 0.07,
                                mprEyeContainerWidth:
                                    _mediaQuery.size.width * 0.07,
                                bigSizedBoxHeight:
                                    _mediaQuery.size.height * 0.03,
                                smallSizedBoxHeight:
                                    _mediaQuery.size.height * 0.03,
                                textButtonHorizontalPadding:
                                    _mediaQuery.size.width * 0.05,
                                textButtonVerticalpadding:
                                    _mediaQuery.size.height * 0.008,
                                textButtonBorderRadius:
                                    _mediaQuery.size.width * 0.06,
                                context: context,
                                mediaQuery: _mediaQuery,
                                headingText: 'Password Reset link sent',
                                subText: 'Go back to Login Page',
                                confirmText: 'Login Page',
                                cancelText: 'Cancel',
                                confirmFunction: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (route) => false);
                                },
                              );
                            }

                            if (result != null) {
                              setState(
                                () {
                                  error = result;
                                },
                              );

                              SnackBar errorSnackBar = SnackBar(
                                elevation: 10,
                                backgroundColor:
                                    kColorSnackBarBackgroundAuthPage,
                                content: Text(
                                  error,
                                  style: kSnackBarTextStyleAuthPage,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(errorSnackBar);
                            }
                          }
                        },
                      ),
                    ),

                    //Error Text
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _mediaQuery.size.width * 0.05),
                        child: Text(
                          error,
                          style: kErrorTextStyleInvalidAuthPage.copyWith(
                              fontSize: _mediaQuery.size.height * 0.012),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
