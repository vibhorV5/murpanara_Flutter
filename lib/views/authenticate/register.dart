import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/forgot_password.dart';
import 'package:murpanara/views/authenticate/google_sign_in_button.dart';
import 'package:murpanara/constants/snackbars.dart';
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

  // AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

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
              // SizedBox(
              //   height: _mediaQuery.size.height * 0.02,
              //   width: _mediaQuery.size.width,
              // ),

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
              SizedBox(height: _mediaQuery.size.height * 0.14),

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
                          hintText: 'Email ID',
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a Valid Email ID.' : null,
                          onChanged: (val) {
                            emailController.text = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialText: ''),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: _mediaQuery.size.width * 0.05,
                      ),
                      // color: Colors.black,
                      child: CustomFormField(
                          inputTextSize: _mediaQuery.size.height * 0.017,
                          fillColor: Colors.grey.shade100,
                          obscureText: true,
                          textController: passwordController,
                          mediaQuery: _mediaQuery,
                          hintText: 'Password',
                          // validator: (value) =>
                          //     value!.isEmpty ? 'Enter a Valid Email ID.' : null,
                          // onChanged: (val) {
                          //   emailController.text = val;
                          // },
                          validator: (value) => value!.length < 6
                              ? 'Enter a Password 6+ chars long.'
                              : null,
                          onChanged: (val) {
                            passwordController.text = val;
                          },
                          keyboardType: TextInputType.emailAddress,
                          initialText: ''),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _mediaQuery.size.width * 0.05,
                          vertical: _mediaQuery.size.height * 0.012),
                      child: SaveButton(
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
                                setState(() {
                                  error = 'Enter a valid Email ID.';
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(invalidEmailSnackBar);
                              }

                              print(emailController.text);
                              print(passwordController.text);
                            }
                          }),
                    ),
                    // Error Text
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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

              SizedBox(height: _mediaQuery.size.height * 0.11),

              // //Register Form
              // Container(
              //     height: _mediaQuery.size.height * 0.285,
              //     width: _mediaQuery.size.width,
              //     color: Colors.amber.withOpacity(0.3),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         //Heading
              //         Container(
              //           // color: Colors.red,
              //           padding: EdgeInsets.only(left: 10),
              //           // color: Colors.red.withOpacity(0.3),
              //           child: Text(
              //             'Register',
              //             style: kHeadingsAuthPage.copyWith(fontSize: 10),
              //           ),
              //         ),

              //         //Fields
              //         Form(
              //           autovalidateMode: AutovalidateMode.disabled,
              //           key: _formKey,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               //Email Form Field
              //               // CustomEmailFormField(
              //               //   emailController: emailController,
              //               //   constraints: constraints,
              //               //   validatorText: 'Enter a Valid Email ID.',
              //               //   hintText: 'Email',
              //               // ),
              //               // Container(
              //               //   height: 25,
              //               //   margin: EdgeInsets.only(
              //               //       left: 10, right: 10, top: 10, bottom: 10),
              //               //   decoration: BoxDecoration(
              //               //     borderRadius: BorderRadius.circular(10),
              //               //     color: kColorFormFieldsAuthPage,
              //               //   ),
              //               //   child: Center(
              //               //     child: Padding(
              //               //       padding: EdgeInsets.only(left: 10),
              //               //       child: TextFormField(
              //               //         validator: (value) => value!.isEmpty
              //               //             ? 'Enter a Valid Email ID.'
              //               //             : null,
              //               //         onChanged: (val) {
              //               //           emailController.text = val;
              //               //         },
              //               //         keyboardType: TextInputType.emailAddress,
              //               //         cursorColor: kColorCursorAuthPage,
              //               //         style: kInputFormFieldsAuthPage,
              //               //         textAlignVertical: TextAlignVertical.center,
              //               //         decoration: InputDecoration(
              //               //           errorStyle: kErrorFormFields,
              //               //           border: InputBorder.none,
              //               //           hintText: 'Email',
              //               //           hintStyle: kHintStyleFormFields.copyWith(
              //               //               fontSize: 10),
              //               //         ),
              //               //       ),
              //               //     ),
              //               //   ),
              //               // ),

              //               //Password Form Field
              //               // CustomPasswordFormField(
              //               //     passwordController: passwordController,
              //               //     constraints: constraints,
              //               //     hintText: 'Password',
              //               //     validatorText:
              //               //         'Enter a Password 6+ chars long.'),

              //               // Container(
              //               //   height: 25,
              //               //   margin: EdgeInsets.only(
              //               //       left: 10, right: 10, top: 10, bottom: 10),
              //               //   decoration: BoxDecoration(
              //               //     borderRadius: BorderRadius.circular(10),
              //               //     color: kColorFormFieldsAuthPage,
              //               //   ),
              //               //   child: Center(
              //               //     child: Padding(
              //               //       padding: EdgeInsets.only(left: 10),
              //               //       child: TextFormField(
              //               //         validator: (value) => value!.length < 6
              //               //             ? 'Enter a Password 6+ chars long.'
              //               //             : null,
              //               //         onChanged: (val) {
              //               //           passwordController.text = val;
              //               //         },
              //               //         obscureText: true,
              //               //         cursorColor: kColorCursorAuthPage,
              //               //         style: kInputFormFieldsAuthPage,
              //               //         textAlignVertical: TextAlignVertical.center,
              //               //         decoration: InputDecoration(
              //               //           errorStyle: kErrorFormFields,
              //               //           border: InputBorder.none,
              //               //           hintText: 'Password',
              //               //           hintStyle: kHintStyleFormFields.copyWith(
              //               //               fontSize: 10),
              //               //         ),
              //               //       ),
              //               //     ),
              //               //   ),
              //               // ),
              //               // Register Button
              //               // () async {
              //               //       FocusScope.of(context).unfocus();
              //               //       if (_formKey.currentState!.validate()) {
              //               //         dynamic result =
              //               //             await AuthService().registerUser(
              //               //           email: emailController,
              //               //           password: passwordController,
              //               //         );
              //               //         if (result == null) {
              //               //           setState(() {
              //               //             error = 'Enter a valid Email ID.';
              //               //           });
              //               //           ScaffoldMessenger.of(context)
              //               //               .showSnackBar(invalidEmailSnackBar);
              //               //         }

              //               //         print(emailController.text);
              //               //         print(passwordController.text);
              //               //       }
              //               //     }
              //               //Error Text
              //               // Center(
              //               //   child: Container(
              //               //     padding: EdgeInsets.symmetric(horizontal: 10),
              //               //     child: Text(
              //               //       error,
              //               //       style: kErrorTextStyleInvalidAuthPage
              //               //           .copyWith(fontSize: 10),
              //               //     ),
              //               //   ),
              //               // ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     )),

              // Google Sign In Button
              const GoogleSignIn(),

              //Already a user?
              Container(
                  height: _mediaQuery.size.height * 0.06,
                  width: _mediaQuery.size.width,
                  // color: Colors.purple.withOpacity(0.4),
                  // color: Colors.green.withOpacity(0.5),
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomEmailFormField extends StatelessWidget {
//   CustomEmailFormField(
//       {Key? key,
//       required this.emailController,
//       required this.constraints,
//       required this.hintText,
//       required this.validatorText})
//       : super(key: key);

//   final TextEditingController emailController;
//   final String hintText;
//   final String validatorText;
//   BoxConstraints constraints;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class CustomPasswordFormField extends StatelessWidget {
//   CustomPasswordFormField(
//       {Key? key,
//       required this.passwordController,
//       required this.constraints,
//       required this.hintText,
//       required this.validatorText})
//       : super(key: key);

//   final TextEditingController passwordController;
//   final String hintText;
//   final String validatorText;
//   BoxConstraints constraints;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
