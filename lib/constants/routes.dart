import 'package:murpanara/views/about/about_us_page.dart';
import 'package:murpanara/views/auth_gate/auth_gate.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:murpanara/views/details/details_page.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/main_page/main_page.dart';
import 'package:murpanara/views/profile/profile_page.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';

var appRoutes = {
  '/': (context) => const AuthGate(),
  'mainPage': (context) => const MainPage(),
  'homePage': (context) => const HomePage(),
  'aboutUsPage': (context) => const AboutUsPage(),
  'checkoutPage': (context) => const CheckoutPage(),
  'detailsPage': (context) => const DetailsPage(),
  'profilePage': (context) => const ProfilePage(),
  'wishlistPage': (context) => const WishlistPage(),
};
