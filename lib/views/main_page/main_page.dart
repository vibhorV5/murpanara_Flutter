import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/providers/selected_index_provider.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/shoppingcart/shopping_cart.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       elevation: 10,
    //       backgroundColor: kColorSnackBarBackgroundAuthPage,
    //       content: Text(
    //         'Welcome to murpanara.',
    //         style: kSnackBarTextStyleAuthPage,
    //       ),
    //     ),
    //   );
    // });
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetoptions = [
    const HomePage(),
    const WishlistPage(),
    const ShoppingCart(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndexProviderData =
        Provider.of<SelectedIndexProvider>(context);

    List<ShoppingCartProduct> shoppingCartProductsListData =
        Provider.of<List<ShoppingCartProduct>>(context);

    final _mediaQuery = MediaQuery.of(context);

    void onTapBay(index) {
      setState(() {
        _selectedIndex = selectedIndexProviderData.getSelectedIndex;
        _selectedIndex = index;

        print('index fucked = selectedIndexProviderData.getSelectedIndex}');
      });
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // margin: EdgeInsets.only(top: 100),
              // color: Colors.red,
              // height: 300,
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    margin: EdgeInsets.only(top: 80, bottom: 30),
                    child: Image.asset('assets/images/mpr_main.png'),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    // color: Colors.blue.withOpacity(0.2),
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 50,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'HOME',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('/');
                            onTapBay(0);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'PROFILE',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('profilePage');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.favorite_rounded,
                            color: Colors.red.shade900,
                          ),
                          title: Text(
                            'WISHLIST',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('wishlistPage');
                            selectedIndexProviderData.setSlectedIndex(1);
                            onTapBay(1);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.shopping_cart_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'SHOPPING CART',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('wishlistPage');
                            selectedIndexProviderData.setSlectedIndex(2);
                            onTapBay(2);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.local_shipping_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'YOUR ORDERS',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('ordersPage');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.info_rounded,
                            color: Colors.black,
                          ),
                          title: Text(
                            'ABOUT US',
                            style: kBold.copyWith(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('aboutUsPage');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.black,
                          ),
                          title: Text(
                            'REFUND & RETURNS',
                            style: kBold.copyWith(fontSize: 13),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed('refundAndReturnPage');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
                top: 50,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  'Logout',
                  style: kBold.copyWith(fontSize: 18),
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  await AuthService().signOut();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            kSemibold.copyWith(fontSize: _mediaQuery.size.height * 0.017),
        unselectedLabelStyle:
            kRegular.copyWith(fontSize: _mediaQuery.size.height * 0.015),
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home_rounded,
              // color: Colors.black,
            ),
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
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
              color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_cart_rounded,
              // color: Colors.black,
            ),
            label: 'Shopping Cart',
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
        ],
        onTap: (index) {
          onTapBay(index);
        },
        currentIndex: _selectedIndex,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Container(
          // color: Colors.red,
          height: _mediaQuery.size.height * 0.06,
          width: _mediaQuery.size.width,
          child: Image.asset('assets/images/mpr_main.png'),
        ),

        // backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pop();
                // selectedIndexProviderData.setSlectedIndex(1);

                onTapBay(2);
              },
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    // color: Colors.red,
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      size: 30,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      shoppingCartProductsListData.length.toString(),
                      style: kSemibold.copyWith(fontSize: 11),
                    ),
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black87),
                    ),
                    height: 15,
                    width: 15,
                  ),
                ],
              )),
          IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushNamed('profilePage');
            },
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.black87,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pushNamed('settingsPage');
          //   },
          //   icon: Icon(Icons.settings_rounded
          //       // color: Colors.black,
          //       ),
          // ),
        ],
      ),
      body: _widgetoptions.elementAt(_selectedIndex),
    );
  }
}
