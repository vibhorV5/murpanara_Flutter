import 'package:flutter/material.dart';
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
                    // color: Colors.red.withOpacity(0.3),
                    child: const Text(
                      'Register',
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
                                    ? 'Enter a Valid Email ID.'
                                    : null,
                                onChanged: (val) {
                                  emailController.text = val;
                                },
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Color.fromARGB(96, 3, 3, 3),
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

                        // Register Button

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
              ),

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
