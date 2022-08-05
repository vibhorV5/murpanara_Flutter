import 'package:flutter/material.dart';
import 'package:murpanara/constants/colors.dart';
import 'package:murpanara/constants/styles.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/providers/selected_index_provider.dart';
import 'package:murpanara/services/auth.dart';
import 'package:murpanara/views/overview/product_overview.dart';
import 'package:murpanara/views/shoppingcart/shopping_cart.dart';
import 'package:murpanara/views/home/home_page.dart';
import 'package:murpanara/views/wishlist/wishlist_page.dart';
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

  final List<Widget> _widgetOptions = [
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
      setState(
        () {
          _selectedIndex = selectedIndexProviderData.getSelectedIndex;
          _selectedIndex = index;

          // print('index fucked = selectedIndexProviderData.getSelectedIndex}');
        },
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    // color: Colors.pink,
                    height: _mediaQuery.size.height * 0.25,
                    width: _mediaQuery.size.width * 0.3,
                    child: Image.asset('assets/images/mpr_main.png'),
                  ),
                  Divider(
                    color: Colors.black54,
                    thickness: _mediaQuery.size.height * 0.001,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: _mediaQuery.size.width * 0.1,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.home_rounded,
                            color: Colors.black,
                            size: _mediaQuery.size.height * 0.03,
                          ),
                          title: Text(
                            'HOME',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
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
                            size: _mediaQuery.size.height * 0.03,
                          ),
                          title: Text(
                            'PROFILE',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
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
                            size: _mediaQuery.size.height * 0.03,
                          ),
                          title: Text(
                            'WISHLIST',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('wishlistPage');
                            selectedIndexProviderData.setSlectedIndex(1);
                            onTapBay(1);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.shopping_cart_rounded,
                              color: Colors.black,
                              size: _mediaQuery.size.height * 0.03),
                          title: Text(
                            'SHOPPING CART',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pushNamed('wishlistPage');
                            selectedIndexProviderData.setSlectedIndex(2);
                            onTapBay(2);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.local_shipping_rounded,
                              color: Colors.black,
                              size: _mediaQuery.size.height * 0.03),
                          title: Text(
                            'YOUR ORDERS',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('ordersPage');
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info_rounded,
                              color: Colors.black,
                              size: _mediaQuery.size.height * 0.03),
                          title: Text(
                            'ABOUT US',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.02),
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
                            size: _mediaQuery.size.height * 0.03,
                          ),
                          title: Text(
                            'REFUND & RETURNS',
                            style: kBold.copyWith(
                                fontSize: _mediaQuery.size.height * 0.015),
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
              Container(
                margin: EdgeInsets.only(
                  left: _mediaQuery.size.width * 0.1,
                  // top: _mediaQuery.size.height * 0.05,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                    size: _mediaQuery.size.height * 0.03,
                  ),
                  title: Text(
                    'Logout',
                    style: kBold.copyWith(
                        fontSize: _mediaQuery.size.height * 0.025),
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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

        centerTitle: true,
        title: SizedBox(
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
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(mediaQuery: _mediaQuery),
              );
            },
            icon: Icon(
              Icons.search,
              size: _mediaQuery.size.height * 0.033,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
              // selectedIndexProviderData.setSlectedIndex(1);

              onTapBay(2);
            },
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  height: _mediaQuery.size.height * 0.033,
                  width: _mediaQuery.size.width * 0.12,
                  // color: Colors.red,
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    size: _mediaQuery.size.height * 0.033,
                    color: Colors.black87,
                  ),
                ),

                //Number
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    shoppingCartProductsListData.length.toString(),
                    style: kSemibold.copyWith(
                        fontSize: _mediaQuery.size.height * 0.0125),
                  ),
                  // margin: EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black87,
                    ),
                  ),
                  height: _mediaQuery.size.height * 0.017,
                  width: _mediaQuery.size.height * 0.017,
                ),
              ],
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.mediaQuery});

  MediaQueryData mediaQuery;
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 0.0,
              ),
        );
  }
  // List<String> searchTerms = [
  //   'Apple',
  //   'Mango',
  //   'Orange',
  //   'Banana',
  //   'Papaya',
  //   'Blueberry',
  //   'Strawberry',
  //   'Peach',
  //   'Grapes',
  //   'Plum',
  //   'Litchi',
  //   'Pomogranate',
  //   'Pineapple',
  // ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear_rounded,
          size: mediaQuery.size.height * 0.025,
          color: Colors.black87,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        size: mediaQuery.size.width * 0.06,
        color: kColorBackIconForgotPassPage,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SubProducts> matchQuery = [];
    final List<Product> productListData = Provider.of<List<Product>>(context);
    final List<SubProducts> subProductsListData =
        productListData.first.subproducts;

    for (var subproduct in subProductsListData) {
      if (subproduct.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(subproduct);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductOverview(subproduct: result)));
            },
            child: ListTile(
              title: Text(result.name),
            ),
          );
        });

    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return ListTile(
    //         title: Text(result),
    //       );
    //     });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SubProducts> matchQuery = [];
    final List<Product> productListData = Provider.of<List<Product>>(context);
    final List<SubProducts> subProductsListData =
        productListData.first.subproducts;

    for (var subproduct in subProductsListData) {
      if (subproduct.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(subproduct);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductOverview(subproduct: result),
                ),
              );
            },
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: mediaQuery.size.height * 0.007),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(mediaQuery.size.height * 0.01),
                ),
                height: mediaQuery.size.height * 0.1,
                width: mediaQuery.size.width * 0.15,
                child: Image.network(result.imagefront),
              ),
              title: Text(
                result.name,
                style: kSemibold.copyWith(
                    fontSize: mediaQuery.size.height * 0.013),
              ),
              trailing: Text(
                '₹${result.price.toString()}.00',
                style: kSemibold.copyWith(
                    fontSize: mediaQuery.size.height * 0.013),
              ),
            ),
          );
        });
    // List<String> matchQuery = [];

    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return ListTile(
    //         title: Text(result),
    //       );
    //     });
  }
}
