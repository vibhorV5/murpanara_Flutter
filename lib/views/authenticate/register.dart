import 'package:flutter/material.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/forgot_password.dart';
import 'package:murpanara/views/authenticate/google_sign_in_button.dart';
import 'package:murpanara/constants/snackbars.dart';
import 'package:murpanara/widgets/AboutUsRefundPageWidgets/big_image_widget.dart';
import 'package:murpanara/widgets/custom_formfield.dart';
import 'package:murpanara/widgets/save_button.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();

  final Function toggleView;
}

class _RegisterState extends State<Register> {
  @override
  void dispose() {
    super.dispose();
    emailController;
    passwordController;
  }

  String error = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
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

              //Sign Up Text
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: _mediaQuery.size.width * 0.05),
                child: Text(
                  'Sign Up',
                  style:
                      kBold.copyWith(fontSize: _mediaQuery.size.height * 0.05),
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Email Id Field
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _mediaQuery.size.width * 0.05,
                          vertical: _mediaQuery.size.height * 0.012),
                      child: CustomFormField(
                          inputTextSize: _mediaQuery.size.height * 0.017,
                          fillColor: Colors.grey.shade100,
                          textController: emailController,
                          mediaQuery: _mediaQuery,
                          hintText: 'Email Id',
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a Valid Email Id' : null,
                          onChanged: (val) {
                            emailController.text = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialText: ''),
                    ),

                    //Password Field
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: _mediaQuery.size.width * 0.05,
                      ),
                      child: CustomFormField(
                          inputTextSize: _mediaQuery.size.height * 0.017,
                          fillColor: Colors.grey.shade100,
                          obscureText: true,
                          textController: passwordController,
                          mediaQuery: _mediaQuery,
                          hintText: 'Password',
                          validator: (value) => value!.length < 6
                              ? 'Enter a Password 6+ chars long.'
                              : null,
                          onChanged: (val) {
                            passwordController.text = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialText: ''),
                    ),

                    //Sign Up Botton
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
                        txt: 'Sign Up',
                        color: Colors.black,
                        txtColor: Colors.white,
                        onPress: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await AuthService().registerUser(
                              email: emailController,
                              password: passwordController,
                            );
                            if (result == null) {
                              setState(
                                () {
                                  error = 'Enter a valid Email ID';
                                },
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(invalidEmailSnackBar);
                            }

                            debugPrint(emailController.text);
                            debugPrint(passwordController.text);
                          }
                        },
                      ),
                    ),

                    // Error Text
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

              SizedBox(height: _mediaQuery.size.height * 0.10),

              // Google Sign In Button
              const GoogleSignIn(),

              //Already a user?/Forgot Password
              Container(
                height: _mediaQuery.size.height * 0.06,
                width: _mediaQuery.size.width,
                margin: EdgeInsets.only(
                  left: _mediaQuery.size.width * 0.03,
                  right: _mediaQuery.size.width * 0.03,
                ),
                child: LayoutBuilder(
                  builder: ((context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a user? ',
                          style: kAlreadyAUserTextStyle.copyWith(
                              fontSize: constraints.maxHeight * 0.28),
                        ),
                        InkWell(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Sign In ',
                            style: kAlreadySignInOptAuthPage.copyWith(
                                fontSize: constraints.maxHeight * 0.29),
                          ),
                        ),
                        Text(
                          '| ',
                          style: kForgotPassTextStyleAuthPage.copyWith(
                              fontSize: constraints.maxHeight * 0.28),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot password?',
                            style: kForgotPassTextStyleAuthPage.copyWith(
                                fontSize: constraints.maxHeight * 0.28),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
