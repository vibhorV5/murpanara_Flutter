import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/textstyles.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/forgot_password.dart';
import 'package:murpanara/widgets/google_sign_in.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();

  final Function toggleView;
}

class _RegisterState extends State<Register> {
  final SnackBar errorSnackBar = SnackBar(
    content: Text('Enter a Valid Email'),
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthService authenticationService = AuthService();

  String error = '';

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
              SizedBox(
                height: _mediaQuery.size.height * 0.02,
              ),
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

              //Register Form
              Container(
                  height: _mediaQuery.size.height * 0.285,
                  color: Colors.amber.withOpacity(0.3),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color: Colors.red,
                            padding: EdgeInsets.only(
                                left: constraints.maxWidth * 0.1),
                            // color: Colors.red.withOpacity(0.3),
                            child: Text(
                              'Register',
                              style: kHeadings.copyWith(
                                  fontSize: constraints.maxHeight * 0.14),
                            ),
                          ),
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //Email Form Field
                                CustomEmailFormField(
                                  emailController: emailController,
                                  constraints: constraints,
                                  validatorText: 'Enter a Valid Email ID.',
                                  hintText: 'Email',
                                ),

                                //Password Form Field
                                CustomPasswordFormField(
                                    passwordController: passwordController,
                                    constraints: constraints,
                                    hintText: 'Password',
                                    validatorText:
                                        'Enter a Password 6+ chars long.'),

                                // Register Button
                                Container(
                                  margin: const EdgeInsets.only(right: 40),
                                  height: 35,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0xFF444444),
                                  ),
                                  child: TextButton(
                                    style: const ButtonStyle(
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        dynamic result =
                                            await AuthService().registerUser(
                                          email: emailController,
                                          password: passwordController,
                                        );
                                        if (result == null) {
                                          // setState(() {
                                          //   error = 'Supply a valid Email';
                                          // });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(errorSnackBar);
                                        }

                                        print(emailController.text);
                                        print(passwordController.text);
                                      }
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    child: Text(
                                      error,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )),

              // Google Sign In Button

              GoogleSignIn(),

              //Already a user?

              Container(
                margin: const EdgeInsets.only(left: 40, right: 40, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a user? ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Container(
                        child: const Text(
                          'Sign In ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF008CB8)),
                        ),
                      ),
                    ),
                    const Text(
                      '| ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: Container(
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
              hintText: 'Email',
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
