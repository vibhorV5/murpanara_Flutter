import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}
