import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String error = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

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
                    'Reset Password',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
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
                                hintText: 'Registered Email',
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

                      // Send Verfication link button
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
                              dynamic result = await AuthService()
                                  .resetPassword(email: emailController);

                              if (result == null) {
                                showDialogBox(context, 'Email sent');

                                await Future.delayed(
                                  Duration(seconds: 2),
                                );

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (route) => false);

                                print(emailController);
                                print(result);
                              }

                              if (result != null) {
                                setState(() {
                                  error = result;
                                });
                              }
                            }
                          },
                          child: const Text(
                            'Request Password Reset',
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
          ],
        )),
      ),
    );
  }

  showDialogBox(BuildContext context, String message) {
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          Container(
            child: Text(message),
          ),
          SizedBox(
            width: 50,
          ),
          Container(
              child: Icon(
            Icons.done,
            color: Colors.green,
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
