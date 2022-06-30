import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/forgot_password.dart';
import 'package:murpanara/views/authenticate/google_sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();

  final Function toggleView;
}

class _SignInState extends State<SignIn> {
  @override
  void dispose() {
    super.dispose();
    emailController;
    passwordController;
  }

  final SnackBar errorSnackBar = const SnackBar(
    elevation: 10,
    backgroundColor: kColorSnackBarBackgroundAuthPage,
    content: Text(
      'Enter Registered Email ID',
      style: kSnackBarTextStyleAuthPage,
    ),
  );

  String error = '';

  String googleErrorMessage = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              SizedBox(
                height: _mediaQuery.size.height * 0.02,
                width: _mediaQuery.size.width,
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

              //Sign In With Email and Password Form
              Container(
                height: _mediaQuery.size.height * 0.285,
                width: _mediaQuery.size.width,
                // color: Colors.amber.withOpacity(0.3),
                child: LayoutBuilder(
                  builder: (context, constraints) {
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
                            'Sign In',
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
                                hintText: 'Email',
                              ),

                              //Password Form Field
                              CustomPasswordFormField(
                                  passwordController: passwordController,
                                  constraints: constraints,
                                  hintText: 'Password',
                                  validatorText:
                                      'Enter a Password 6+ chars long.'),

                              //SignIn Button
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
                                      dynamic result =
                                          await AuthService().signIn(
                                        email: emailController,
                                        password: passwordController,
                                      );

                                      if (result == null) {
                                        setState(() {
                                          error = 'Enter Registered Email ID';
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(errorSnackBar);
                                      }
                                      print(emailController);
                                      print(passwordController);
                                    }
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: kButtonTextStyleConfirmAuthPage
                                        .copyWith(
                                            fontSize:
                                                constraints.maxHeight * 0.065),
                                  ),
                                ),
                              ),

                              //Error text
                              Center(
                                child: Container(
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
                  },
                ),
              ),

              // Google Sign In Button
              const GoogleSignIn(),

              //Don't Have an Account
              Container(
                height: _mediaQuery.size.height * 0.06,
                width: _mediaQuery.size.width,
                // color: Colors.purple.withOpacity(0.4),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Container(
                        // color: Colors.green.withOpacity(0.5),
                        margin: EdgeInsets.only(
                            left: constraints.maxWidth * 0.02,
                            right: constraints.maxWidth * 0.02,
                            top: constraints.maxHeight * 0.4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: kAlreadyAUserTextStyle.copyWith(
                                  fontSize: constraints.maxHeight * 0.33),
                            ),
                            InkWell(
                              onTap: () {
                                widget.toggleView();
                              },
                              child: Text(
                                'Register ',
                                style: kAlreadySignInOptAuthPage.copyWith(
                                    fontSize: constraints.maxHeight * 0.33),
                              ),
                            ),
                            Text(
                              '| ',
                              style: kForgotPassTextStyleAuthPage.copyWith(
                                  fontSize: constraints.maxHeight * 0.33),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                'Forgot password?',
                                style: kForgotPassTextStyleAuthPage.copyWith(
                                    fontSize: constraints.maxHeight * 0.33),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

class CustomPasswordFormField extends StatelessWidget {
  CustomPasswordFormField(
      {Key? key,
      required this.passwordController,
      required this.constraints,
      required this.hintText,
      required this.validatorText})
      : super(key: key);

  final TextEditingController passwordController;
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
          bottom: constraints.maxHeight * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(constraints.maxHeight * 0.08),
        color: kColorFormFieldsAuthPage,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * 0.04),
          child: TextFormField(
            validator: (value) => value!.length < 6 ? validatorText : null,
            onChanged: (val) {
              passwordController.text = val;
            },
            obscureText: true,
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
