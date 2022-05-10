import 'package:flutter/material.dart';
import 'package:murpanara/constants/routes.dart';
import 'package:murpanara/models/app_user.dart';
import 'package:murpanara/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>(
          create: (_) => AuthService().userAuthState,
          initialData: AppUser(uid: ''),
          catchError: (_, __) => AppUser(uid: 'error'),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'murpanara',
        routes: appRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
