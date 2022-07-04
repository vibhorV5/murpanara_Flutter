import 'package:flutter/material.dart';

class ProfileEditingPage extends StatefulWidget {
  const ProfileEditingPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditingPage> createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Form fields goes here'),
      ),
    );
  }
}
