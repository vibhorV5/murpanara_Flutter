import 'package:flutter/material.dart';
import 'package:murpanara/constants/routes.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/providers/quantity_provider.dart';
import 'package:murpanara/providers/size_provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => SizeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuantityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutDetailsProvider(),
        ),
        StreamProvider<List<Product>>(
          create: (_) => DatabaseServices().productsStream,
          initialData: const [],
        ),
        StreamProvider<List<ShoppingCartProduct>>(
          create: (_) => DatabaseServices().shoppingCartProductStream,
          initialData: const [],
        ),
        // StreamProvider<PersonalDetails>(
        //   create: (_) => DatabaseServices().personalDetailsStream,
        //   initialData: PersonalDetails(),
        // ),
        // StreamProvider<BillingAddress>(
        //   create: (_) => DatabaseServices().billingAddressStream,
        //   initialData: BillingAddress(),
        // ),
        StreamProvider<DeliveryAddress>(
          create: (_) => DatabaseServices().deliveryAddressStream,
          initialData: DeliveryAddress(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'murpanara',
        routes: appRoutes,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.transparent,
        ),
      ),
    );
  }
}
