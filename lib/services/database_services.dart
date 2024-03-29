import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/services/auth.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseServices {
  final String? uid;

  DatabaseServices({this.uid});

  //Collection Reference for products
  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  //Collection Reference for wishlist
  CollectionReference wishlistCollection =
      FirebaseFirestore.instance.collection('wishlist');

  //Collection Reference for shopping cart
  CollectionReference shoppingcartCollection =
      FirebaseFirestore.instance.collection('shoppingcart');

  //Collection Reference for billing address
  CollectionReference billingAddressCollection =
      FirebaseFirestore.instance.collection('billingAddress');

  //Collection Reference for delivery address
  CollectionReference deliveryAddressCollection =
      FirebaseFirestore.instance.collection('deliveryAddress');

  //Collection Reference for personal details
  CollectionReference personalDetailsCollection =
      FirebaseFirestore.instance.collection('personalDetails');

  //Collection Reference for user orders
  CollectionReference userOrdersCollection =
      FirebaseFirestore.instance.collection('userOrders');

//Clear shopping cart list
  Future<void> clearShoppingCartList() async {
    var user = AuthService().currentUser!;

    await shoppingcartCollection.doc(user.uid).delete();
  }

//Fetch userOrders
  List<UserOrders> _getUserOrders(DocumentSnapshot snapshot) {
    return snapshot.data().toString().contains('userOrders')
        ? (snapshot.get('userOrders') as List).map((field) {
            return UserOrders(
              amountPaid: field['amountPaid'],
              deliveryAddress: field['deliveryAddress'],
              emailId: field['emailId'],
              firstName: field['firstName'],
              lastName: field['lastName'],
              modeOfPayment: field['modeOfPayment'],
              orderId: field['orderId'],
              orderStatus: field['orderStatus'],
              orderTime: field['orderTime'],
              phone: field['phone'],
              orderedProducts: ((field['orderedProducts']) as List)
                  .map((p) => ShoppingCartProduct(
                        productId: p['productId'],
                        name: p['name'],
                        imagefront: p['imagefront'],
                        imageback: p['imageback'],
                        price: p['price'],
                        fit: p['fit'],
                        composition: p['composition'],
                        size: p['size'],
                        quantity: p['quantity'],
                      ))
                  .toList(),
            );
          }).toList()
        : const [];
  }

  Stream<List<UserOrders>> get userOrdersStream {
    // var user = AuthService().currentUser!;
    // return personalDetailsCollection.doc(user.uid).snapshots().map(
    //       (event) => _getPersonalDetails(event),
    //     );
    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = userOrdersCollection.doc(user.uid);
        return ref.snapshots().map(_getUserOrders);
      } else {
        return Stream.fromIterable([]);
      }
    });
  }

//set user order
  Future<void> setUserOrder({required UserOrders userOrders}) async {
    var user = AuthService().currentUser!;
    var ref = userOrdersCollection.doc(user.uid);

    final orderproductslist = userOrders.orderedProducts
        .map((p) => {
              "name": p.name,
              "imagefront": p.imagefront,
              "imageback": p.imageback,
              "productId": p.productId,
              "fit": p.fit,
              "composition": p.composition,
              "price": p.price,
              "size": p.size,
              "quantity": p.quantity,
            })
        .toList();

    var nestedData = {
      'firstName': userOrders.firstName,
      'lastName': userOrders.lastName,
      'phone': userOrders.phone,
      'emailId': userOrders.emailId,
      'deliveryAddress': userOrders.deliveryAddress,
      'amountPaid': userOrders.amountPaid,
      'orderStatus': userOrders.orderStatus,
      'modeOfPayment': userOrders.modeOfPayment,
      'orderTime': userOrders.orderTime,
      'orderId': userOrders.orderId,
      'orderedProducts': orderproductslist,
    };
    var data = {
      'userOrders': FieldValue.arrayUnion([nestedData])
    };

    await ref.set(data, SetOptions(merge: true));
  }

// //set user order
//   Future<void> setUserOrder({required UserOrders userOrders}) async {
//     var user = AuthService().currentUser!;
//     var nestedData = {
//       'firstName': userOrders.firstName,
//       'lastName': userOrders.lastName,
//       'phone': userOrders.phone,
//       'emailId': userOrders.emailId,
//       'deliveryAddress': userOrders.deliveryAddress,
//       'amountPaid': userOrders.amountPaid,
//       'orderStatus': userOrders.orderStatus,
//       'modeOfPayment': userOrders.modeOfPayment,
//       'orderedProducts': userOrders.orderedProducts,
//       'orderTime': userOrders.orderTime,
//       'orderId': userOrders.orderId,
//     };

  PersonalDetails _getPersonalDetails(DocumentSnapshot snapshot) {
    return PersonalDetails(
      firstName: snapshot.data().toString().contains('firstName')
          ? snapshot.get('firstName')
          : '',
      lastName: snapshot.data().toString().contains('lastName')
          ? snapshot.get('lastName')
          : '',
      dob:
          snapshot.data().toString().contains('dob') ? snapshot.get('dob') : '',
      phoneNumber: snapshot.data().toString().contains('phoneNumber')
          ? snapshot.get('phoneNumber')
          : 0,
      gender: snapshot.data().toString().contains('gender')
          ? snapshot.get('gender')
          : '',
    );
  }

  Stream<PersonalDetails> get personalDetailsStream {
    // var user = AuthService().currentUser!;
    // return personalDetailsCollection.doc(user.uid).snapshots().map(
    //       (event) => _getPersonalDetails(event),
    //     );
    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap(
      (user) {
        if (user != null) {
          var ref = personalDetailsCollection.doc(user.uid);
          return ref.snapshots().map(_getPersonalDetails);
        } else {
          return Stream.fromIterable([PersonalDetails()]);
        }
      },
    );
  }

  ///FETCHING DATA

  //List of Products from Snapshot
  List<Product> _getProductsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc) {
        return Product(
          subproducts: doc.data().toString().contains('subproducts')
              ? (doc.get('subproducts') as List)
                  .map(
                    (product) => SubProducts(
                      productId: product['productId'],
                      name: product['name'],
                      imagefront: product['imagefront'],
                      imageback: product['imageback'],
                      fit: product['fit'],
                      composition: product['composition'],
                      price: product['price'],
                      size: product['size'],
                      status: product['status'],
                    ),
                  )
                  .toList()
              : const [],
          name: doc.data().toString().contains('name') ? doc.get('name') : '',
        );
      },
    ).toList();
  }

  //Get Products Stream
  Stream<List<Product>> get productsStream {
    return productsCollection.snapshots().map(_getProductsFromSnapshot);
  }

  //List of wishlist SubProducts from document snapshot
  List<SubProducts> _getwishListSubproductsfromsnapshot(
      DocumentSnapshot snapshot) {
    return snapshot.data().toString().contains('subproducts')
        ? (snapshot.get('subproducts') as List)
            .map(
              (product) => SubProducts(
                name: product['name'],
                imagefront: product['imagefront'],
                imageback: product['imageback'],
                fit: product['fit'],
                composition: product['composition'],
                price: product['price'],
                productId: product['productId'],
                size: product['size'],
                status: product['status'],
              ),
            )
            .toList()
        : const [];
  }

  //Get Wishlist Stream
  Stream<List<SubProducts>> get wishlistSubproductsStream {
    // var user = AuthService().currentUser!;
    // return wishlistCollection
    //     .doc(user.uid)
    //     .snapshots()
    //     .map(_getwishListSubproductsfromsnapshot);

    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = wishlistCollection.doc(user.uid);
        return ref.snapshots().map(_getwishListSubproductsfromsnapshot);
      } else {
        return Stream.fromIterable([]);
      }
    });
  }

  BillingAddress _getBillingAddress(DocumentSnapshot snapshot) {
    return BillingAddress(
      addressLine1: snapshot.data().toString().contains('addressLine1')
          ? snapshot.get('addressLine1')
          : '',
      addressLine2: snapshot.data().toString().contains('addressLine2')
          ? snapshot.get('addressLine2')
          : '',
      pincode: snapshot.data().toString().contains('pincode')
          ? snapshot.get('pincode')
          : 0,
      city: snapshot.data().toString().contains('city')
          ? snapshot.get('city')
          : '',
      state: snapshot.data().toString().contains('state')
          ? snapshot.get('state')
          : '',
      country: snapshot.data().toString().contains('country')
          ? snapshot.get('country')
          : '',
    );
  }

  Stream<BillingAddress> get billingAddressStream {
    // var user = AuthService().currentUser!;
    // return billingAddressCollection
    //     .doc(user.uid)
    //     .snapshots()
    //     .map(_getBillingAddress);

    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = billingAddressCollection.doc(user.uid);
        return ref.snapshots().map(_getBillingAddress);
      } else {
        return Stream.fromIterable([BillingAddress()]);
      }
    });
  }

  DeliveryAddress _getDeliveryAddress(DocumentSnapshot snapshot) {
    return DeliveryAddress(
      firstName: snapshot.data().toString().contains('firstName')
          ? snapshot.get('firstName')
          : '',
      lastName: snapshot.data().toString().contains('lastName')
          ? snapshot.get('lastName')
          : '',
      addressLine1: snapshot.data().toString().contains('addressLine1')
          ? snapshot.get('addressLine1')
          : '',
      addressLine2: snapshot.data().toString().contains('addressLine2')
          ? snapshot.get('addressLine2')
          : '',
      pincode: snapshot.data().toString().contains('pincode')
          ? snapshot.get('pincode')
          : 0,
      phone: snapshot.data().toString().contains('phone')
          ? snapshot.get('phone')
          : 0,
      city: snapshot.data().toString().contains('city')
          ? snapshot.get('city')
          : '',
      state: snapshot.data().toString().contains('state')
          ? snapshot.get('state')
          : '',
      country: snapshot.data().toString().contains('country')
          ? snapshot.get('country')
          : '',
    );
  }

  Stream<DeliveryAddress> get deliveryAddressStream {
    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap(
      (user) {
        if (user != null) {
          var ref = deliveryAddressCollection.doc(user.uid);
          return ref.snapshots().map(_getDeliveryAddress);
        } else {
          return Stream.fromIterable([DeliveryAddress()]);
        }
      },
    );

    // return deliveryAddressCollection
    //     .doc(user.uid)
    //     .snapshots()
    //     .map(_getDeliveryAddress);
  }

  //List of ShoppingCartProduct from document snapshot
  List<ShoppingCartProduct> _getShoppingCartProductsfromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return documentSnapshot.data().toString().contains('shoppingcart')
        ? (documentSnapshot.get('shoppingcart') as List).map(
            (product) {
              return ShoppingCartProduct(
                name: product['name'],
                imagefront: product['imagefront'],
                imageback: product['imageback'],
                fit: product['fit'],
                composition: product['composition'],
                price: product['price'],
                productId: product['productId'],
                size: product['size'],
                quantity: product['quantity'],
              );
            },
          ).toList()
        : const [];
  }

  //Get shoppingcart Stream from firestore
  Stream<List<ShoppingCartProduct>> get shoppingCartProductStream {
    // var user = AuthService().currentUser!;
    // return shoppingcartCollection
    //     .doc(user.uid)
    //     .snapshots()
    //     .map(_getShoppingCartProductsfromSnapshot);
    // var user = AuthService().currentUser!;

    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = shoppingcartCollection.doc(user.uid);
        return ref.snapshots().map(_getShoppingCartProductsfromSnapshot);
      } else {
        return Stream.fromIterable([]);
      }
    });
  }

  ///SETTING DATA

  //Set Wishlist item
  Future<void> setWishlistItemOnFirestore(
      {required SubProducts subProducts}) async {
    final nestedData = {
      'name': subProducts.name,
      'imagefront': subProducts.imagefront,
      'imageback': subProducts.imageback,
      'fit': subProducts.fit,
      'composition': subProducts.composition,
      'price': subProducts.price,
      'productId': subProducts.productId,
      'size': subProducts.size,
      'status': subProducts.status,
    };

    var user = AuthService().currentUser!;
    var ref = wishlistCollection.doc(user.uid);

    var data = {
      'subproducts': FieldValue.arrayUnion([nestedData])
    };
    return await ref.set(data, SetOptions(merge: true));
  }

  //Set ShoppingCart item
  Future<void> setShoppingCartItem(
      {required SubProducts subProducts,
      required String productSize,
      required num productQuantity}) async {
    final nestedData = {
      'name': subProducts.name,
      'imagefront': subProducts.imagefront,
      'imageback': subProducts.imageback,
      'fit': subProducts.fit,
      'composition': subProducts.composition,
      'price': subProducts.price,
      'productId': subProducts.productId,
      'size': productSize,
      'quantity': productQuantity,
    };

    var user = AuthService().currentUser!;
    var ref = shoppingcartCollection.doc(user.uid);

    var data = {
      'shoppingcart': FieldValue.arrayUnion([nestedData])
    };
    return await ref.set(data, SetOptions(merge: true));
  }

  Future<void> setBillingAddress(
      {required BillingAddress billingAddress}) async {
    final data = {
      'addressLine1': billingAddress.addressLine1,
      'addressLine2': billingAddress.addressLine2,
      'pincode': billingAddress.pincode,
      'city': billingAddress.city,
      'state': billingAddress.state,
      'country': 'India',
    };

    var user = AuthService().currentUser!;
    var ref = billingAddressCollection.doc(user.uid);

    return await ref.set(data);
  }

  Future<void> setDeliveryAddress(
      {required DeliveryAddress deliveryAddress}) async {
    final data = {
      'firstName': deliveryAddress.firstName,
      'lastName': deliveryAddress.lastName,
      'addressLine1': deliveryAddress.addressLine1,
      'addressLine2': deliveryAddress.addressLine2,
      'pincode': deliveryAddress.pincode,
      'phone': deliveryAddress.phone,
      'city': deliveryAddress.city,
      'state': deliveryAddress.state,
      'country': 'India',
    };

    var user = AuthService().currentUser!;
    var ref = deliveryAddressCollection.doc(user.uid);

    return await ref.set(data);
  }

  Future<void> setPersonalDetails(
      {required PersonalDetails personalDetails}) async {
    final data = {
      'firstName': personalDetails.firstName,
      'lastName': personalDetails.lastName,
      'dob': personalDetails.dob,
      'phoneNumber': personalDetails.phoneNumber,
      'gender': personalDetails.gender,
    };

    var user = AuthService().currentUser!;
    var ref = personalDetailsCollection.doc(user.uid);

    return await ref.set(data);
  }

  ///DELETING DATA

  //Deleting a Wishlist Subproduct
  Future deleteWishlistItemOnFirestore(
      {required SubProducts subProducts}) async {
    final nestedData = {
      'name': subProducts.name,
      'imagefront': subProducts.imagefront,
      'imageback': subProducts.imageback,
      'fit': subProducts.fit,
      'composition': subProducts.composition,
      'price': subProducts.price,
      'productId': subProducts.productId,
      'size': subProducts.size,
      'status': subProducts.status,
    };

    var user = AuthService().currentUser!;
    await wishlistCollection.doc(user.uid).update(
      {
        'subproducts': FieldValue.arrayRemove([nestedData])
      },
    );
  }

  //Delete shoppingCart item
  Future deleteShoppingCartItemOnFirestore(
      {required ShoppingCartProduct shoppingCartProduct}) async {
    final nestedData = {
      'name': shoppingCartProduct.name,
      'imagefront': shoppingCartProduct.imagefront,
      'imageback': shoppingCartProduct.imageback,
      'fit': shoppingCartProduct.fit,
      'composition': shoppingCartProduct.composition,
      'price': shoppingCartProduct.price,
      'productId': shoppingCartProduct.productId,
      'quantity': shoppingCartProduct.quantity,
      'size': shoppingCartProduct.size,
    };

    var user = AuthService().currentUser!;
    await shoppingcartCollection.doc(user.uid).update(
      {
        'shoppingcart': FieldValue.arrayRemove([nestedData])
      },
    );
  }

  Future<void> removeBillingAddress() async {
    var user = AuthService().currentUser!;
    await billingAddressCollection.doc(user.uid).delete();
  }

  Future<void> removeDeliveryAddress() async {
    var user = AuthService().currentUser!;
    await deliveryAddressCollection.doc(user.uid).delete();
  }

  ///Checks

  //Check SubProducts item on wishlist on firestore wishlist collection
  Future<bool> checkItem({required SubProducts subproduct}) async {
    bool isWishlisted = false;
    var subList = [];

    var user = AuthService().currentUser!;
    var ref = wishlistCollection.doc(user.uid);

    await ref.get().then(
      (value) {
        value.data().toString().contains('subproducts')
            ? (value.get('subproducts') as List).forEach(
                (element) {
                  subList.add(element);
                  for (var map in subList) {
                    if (map?.containsKey('productId') ?? false) {
                      if (map!["productId"] == subproduct.productId) {
                        isWishlisted = true;
                      }
                    } else {
                      isWishlisted = false;
                    }
                  }
                },
              )
            : false;
      },
    );
    subList = [];
    return isWishlisted;
  }

  Future<bool> checkShoppingCartItem(
      {required SubProducts subproduct,
      required int quantity,
      required String size}) async {
    bool isWishlisted = false;
    var subList = [];

    var user = AuthService().currentUser!;
    var ref = shoppingcartCollection.doc(user.uid);

    await ref.get().then(
      (value) {
        value.data().toString().contains('shoppingcart')
            ? (value.get('shoppingcart') as List).forEach(
                (element) {
                  subList.add(element);
                  for (var map in subList) {
                    if (map?.containsKey('productId') ?? false) {
                      if ((map!["productId"] == subproduct.productId) &&
                          (map!["quantity"] == quantity) &&
                          (map!["size"] == size)) {
                        isWishlisted = true;
                      }
                    } else {
                      isWishlisted = false;
                    }
                  }
                },
              )
            : false;
      },
    );
    subList = [];
    return isWishlisted;
  }
}
