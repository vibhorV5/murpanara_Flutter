import 'package:flutter/material.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/shoppingcart/shopping_cart.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    ShoppingCart(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(context: context),
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home_rounded,
              // color: Colors.black,
            ),
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
              // color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.favorite_rounded,
              // color: Colors.black,
            ),
            label: 'Wishlist',
            icon: Icon(
              Icons.favorite_outline_rounded,
              // color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_bag,
              // color: Colors.black,
            ),
            label: 'Shopping Cart',
            icon: Icon(
              Icons.shopping_bag_outlined,
              // color: Colors.black,
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
        // iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Container(
            // color: Colors.red,
            height: 50,
            width: 100,
            child: Image.asset('assets/images/mpr_main.png')),
        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // IconButton(
          //   onPressed: () async {
          //     await AuthService().signOut();
          //   },
          //   icon: const Icon(
          //     Icons.logout_outlined,
          //     // color: Colors.black,
          //   ),
          // ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('settingsPage');
            },
            icon: Icon(Icons.settings_rounded
                // color: Colors.black,
                ),
          ),
        ],
      ),
      body: _widgetoptions.elementAt(_selectedIndex),
    );
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key, required this.context}) : super(key: key);

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            // color: Colors.red,
            height: 300,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.account_circle_rounded),
                    title: Text(
                      'Profile',
                      style: TextStyle(fontSize: 40),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('profilePage');
                    },
                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.favorite_rounded),
                //   title: Text(
                //     'Wishlist',
                //     style: TextStyle(fontSize: 40),
                //   ),
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pushNamed('wishlistPage');
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(
                      'Your Orders',
                      style: TextStyle(fontSize: 40),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('ordersPage');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.info_rounded),
                    title: Text(
                      'About Us',
                      style: TextStyle(fontSize: 40),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('aboutUsPage');
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 35),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                await AuthService().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
