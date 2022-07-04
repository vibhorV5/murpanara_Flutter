import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/auth.dart';

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Blank Space
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  // color: Colors.purple,
                  padding: EdgeInsets.only(
                      top: _mediaQuery.size.height * 0.01,
                      left: _mediaQuery.size.width * 0.01),
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: _mediaQuery.size.width * 0.065,
                    color: kColorBackIconForgotPassPage,
                  ),
                  // color: Colors.amber.withOpacity(0.4),
                  height: _mediaQuery.size.height * 0.04,
                  width: _mediaQuery.size.width,
                ),
              ),

              //Murpanara Logo Image
              Container(
                height: _mediaQuery.size.height * 0.25,
                width: _mediaQuery.size.width,
                // color: Colors.red.withOpacity(0.3),
                child: LayoutBuilder(
                  builder: ((context, constraints) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.05,
                          bottom: constraints.maxHeight * 0.04,
                          left: constraints.maxWidth * 0.1,
                          right: constraints.maxWidth * 0.1),
                      child: Image.asset(
                        'assets/images/mpr_main.png',
                      ),
                    );
                  }),
                ),
              ),

              //Blank space
              SizedBox(height: _mediaQuery.size.height * 0.1),

              Container(
                height: _mediaQuery.size.height * 0.285,
                width: _mediaQuery.size.width,
                child: LayoutBuilder(
                  builder: ((context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Heading
                        Container(
                          // color: Colors.red,
                          padding:
                              EdgeInsets.only(left: constraints.maxWidth * 0.1),
                          // color: Colors.red.withOpacity(0.3),
                          child: Text(
                            'Reset Password',
                            style: kHeadingsAuthPage.copyWith(
                                fontSize: constraints.maxHeight * 0.14),
                          ),
                        ),

                        //Fields
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //Email Form Field
                              CustomEmailFormField(
                                emailController: emailController,
                                constraints: constraints,
                                validatorText: 'Enter Registered Email ID.',
                                hintText: 'Registered Email',
                              ),

                              //Request Password Reset button
                              Container(
                                margin: EdgeInsets.only(
                                    right: constraints.maxWidth * 0.1),
                                height: constraints.maxHeight * 0.15,
                                padding: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.05,
                                    right: constraints.maxWidth * 0.05),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      constraints.maxHeight * 0.4),
                                  color: kColorButtonConfirmAuthPage,
                                ),
                                child: TextButton(
                                  style: kButtonStyleConfirmAuthPage,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await AuthService()
                                          .resetPassword(
                                              email: emailController);

                                      if (result == null) {
                                        showDialogBox(
                                            mediaQuery: _mediaQuery,
                                            context: context,
                                            message: 'Email Sent.');

                                        await Future.delayed(
                                          Duration(seconds: 2),
                                        );

                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/', (route) => false);

                                        print(emailController);
                                        print(result);
                                      }

                                      if (result != null) {
                                        setState(() {
                                          error = result;
                                        });

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
                                  child: Text(
                                    'Request Password Reset',
                                    style: kButtonTextStyleConfirmAuthPage
                                        .copyWith(
                                            fontSize:
                                                constraints.maxHeight * 0.065),
                                  ),
                                ),
                              ),

                              //Error Text
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: constraints.maxHeight * 0.03),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.03),
                                  child: Text(
                                    error,
                                    style:
                                        kErrorTextStyleInvalidAuthPage.copyWith(
                                            fontSize:
                                                constraints.maxHeight * 0.055),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox(
      {required BuildContext context,
      required String message,
      required MediaQueryData mediaQuery}) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mediaQuery.size.height * 0.05,
            width: mediaQuery.size.width * 0.1,
            child: Text(
              message,
              style: kDialogTextStyleForgotPass,
            ),
          ),
          Container(
              child: Icon(
            Icons.done,
            size: mediaQuery.size.height * 0.05,
            color: kColorAlertDialogIconAuthPage,
          )),
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}

class CustomEmailFormField extends StatelessWidget {
  CustomEmailFormField(
      {Key? key,
      required this.emailController,
      required this.constraints,
      required this.hintText,
      required this.validatorText})
      : super(key: key);

  final TextEditingController emailController;
  final String hintText;
  final String validatorText;
  BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.25,
      margin: EdgeInsets.only(
          left: constraints.maxWidth * 0.1,
          right: constraints.maxWidth * 0.1,
          top: constraints.maxHeight * 0.04,
          bottom: constraints.maxHeight * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(constraints.maxHeight * 0.08),
        color: kColorFormFieldsAuthPage,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * 0.04),
          child: TextFormField(
            validator: (value) => value!.isEmpty ? validatorText : null,
            onChanged: (val) {
              emailController.text = val;
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
                  fontSize: constraints.maxHeight * 0.09),
            ),
          ),
        ),
      ),
    );
  }
}
