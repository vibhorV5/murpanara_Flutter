import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:murpanara/constants/routes.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/models/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/providers/checkout_details_provider.dart';
import 'package:murpanara/providers/quantity_provider.dart';
import 'package:murpanara/providers/selected_index_provider.dart';
import 'package:murpanara/providers/size_provider.dart';
import 'package:murpanara/services/database_services.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', //id,
  'High Importance Notifications', //title
  // 'This channel is used for important notifications', //description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('A bg message just showed up : ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
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
        ChangeNotifierProvider(
          create: (_) => SelectedIndexProvider(),
        ),
        StreamProvider<List<Product>>(
          create: (_) => DatabaseServices().productsStream,
          initialData: const [],
        ),
        StreamProvider<List<SubProducts>>(
          create: (_) => DatabaseServices().wishlistSubproductsStream,
          initialData: const [],
        ),
        StreamProvider<List<ShoppingCartProduct>>(
          create: (_) => DatabaseServices().shoppingCartProductStream,
          initialData: const [],
        ),
        StreamProvider<PersonalDetails>(
          create: (_) => DatabaseServices().personalDetailsStream,
          initialData: PersonalDetails(),
        ),
        StreamProvider<BillingAddress>(
          create: (_) => DatabaseServices().billingAddressStream,
          initialData: BillingAddress(),
        ),
        StreamProvider<DeliveryAddress>(
          create: (_) => DatabaseServices().deliveryAddressStream,
          initialData: DeliveryAddress(),
        ),
        StreamProvider<List<UserOrders>>(
          create: (_) => DatabaseServices().userOrdersStream,
          initialData: const [],
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
