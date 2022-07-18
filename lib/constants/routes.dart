import 'package:murpanara/views/about/about_us_page.dart';
import 'package:murpanara/views/auth_gate/auth_gate.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/main_page/main_page.dart';
import 'package:murpanara/views/orders/orders_page.dart';
import 'package:murpanara/views/profile/delivery_address_edit.dart';
import 'package:murpanara/views/profile/profile_page.dart';
import 'package:murpanara/views/settings/settings_page.dart';
import 'package:murpanara/views/shoppingcart/shopping_cart.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';

var appRoutes = {
  '/': (context) => const AuthGate(),
  'mainPage': (context) => const MainPage(),
  'homePage': (context) => const HomePage(),
  'aboutUsPage': (context) => const AboutUsPage(),
  'shoppingCart': (context) => const ShoppingCart(),
  'profilePage': (context) => const ProfilePage(),
  'wishlistPage': (context) => const WishlistPage(),
  'ordersPage': (context) => const OrdersPage(),
  'settingsPage': (context) => const SettingsPage(),
  'deliveryAddressEdit': (context) => const DeliveryAddressEdit(),
  'checkoutPage': (context) => const CheckoutPage(),
};
