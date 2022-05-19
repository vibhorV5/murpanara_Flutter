import 'package:flutter/material.dart';
import 'package:murpanara/constants/routes.dart';
import 'package:murpanara/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:murpanara/models/subproducts.dart';
import 'package:murpanara/services/database_services.dart';
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
        StreamProvider<List<Product>>(
          create: (_) => DatabaseServices().productsStream,
          initialData: const [],
        ),
        StreamProvider<List<SubproductsMain>>(
          create: (_) => DatabaseServices().subproductsStream,
          initialData: const [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'murpanara',
        routes: appRoutes,
        theme: ThemeData.light(),
      ),
    );
  }
}
