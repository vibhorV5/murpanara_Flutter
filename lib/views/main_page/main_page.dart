import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/checkout/checkout_page.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wecome to murpanara!")),
      );
    });

    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;

  List<Widget> _widgetoptions = [
    HomePage(),
    WishlistPage(),
    CheckoutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Wishlist',
            icon: Icon(Icons.favorite_outline),
          ),
          BottomNavigationBarItem(
            label: 'Shopping Cart',
            icon: Icon(
              Icons.shopping_bag_outlined,
            ),
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: _widgetoptions.elementAt(_selectedIndex),
    );
  }
}
