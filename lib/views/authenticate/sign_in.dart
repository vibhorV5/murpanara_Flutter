import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/authenticate/forgot_password.dart';
import 'package:murpanara/widgets/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();

  final Function toggleView;
}

class _SignInState extends State<SignIn> {
  final SnackBar errorSnackBar = SnackBar(
    content: Text('Enter a Valid Email'),
  );

  String error = '';
  String googleErrorMessage = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 55, right: 55, top: 30),
                child: Image.asset(
                  'assets/images/mpr_main.png',
                ),
              ),
              const SizedBox(height: 80),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40),
                    child: const Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE9E9E9),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Enter Registered Email ID.'
                                    : null,
                                onChanged: (val) {
                                  emailController.text = val;
                                },
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black38,
                                style: const TextStyle(color: Colors.black87),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB1B1B1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFE9E9E9),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                validator: (value) => value!.length < 6
                                    ? 'Enter a Password 6+ chars long.'
                                    : null,
                                onChanged: (val) {
                                  passwordController.text = val;
                                },
                                obscureText: true,
                                cursorColor: Colors.black38,
                                style: const TextStyle(color: Colors.black87),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  errorStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB1B1B1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // SignIn Button
                        Container(
                          margin: const EdgeInsets.only(right: 40),
                          height: 35,
                          padding: const EdgeInsets.only(left: 15, right: 15),
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
                                dynamic result = await AuthService().signIn(
                                  email: emailController,
                                  password: passwordController,
                                );

                                if (result == null) {
                                  // setState(() {
                                  //   error = 'Enter Registered Email ID';
                                  // });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(errorSnackBar);
                                }
                                print(emailController);
                                print(passwordController);
                              }
                            },
                            child: const Text(
                              'Sign In',
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
              ),

              // Google Sign In Button

              GoogleSignIn(),

              //Already a user?

              Container(
                margin: const EdgeInsets.only(left: 35, right: 35, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      ' Don\'t have an account? ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Container(
                        child: const Text(
                          'Register ',
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
