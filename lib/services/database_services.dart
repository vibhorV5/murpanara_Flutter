import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:murpanara/models/billing_address.dart';
import 'package:murpanara/models/delivery_address.dart';
import 'package:murpanara/models/personal_details.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/models/shoppingcartproduct.dart';
import 'package:murpanara/services/auth.dart';

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

  CollectionReference personalDetailsCollection =
      FirebaseFirestore.instance.collection('personalDetails');

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
    var user = AuthService().currentUser!;
    return personalDetailsCollection.doc(user.uid).snapshots().map(
          (event) => _getPersonalDetails(event),
        );
  }

  ///FETCHING DATA

  //List of Products from Snapshot
  List<Product> _getProductsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
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
                  ),
                )
                .toList()
            : const [],
        name: doc.data().toString().contains('name') ? doc.get('name') : '',
      );
    }).toList();
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
              ),
            )
            .toList()
        : const [];
  }

  //Get Wishlist Stream
  Stream<List<SubProducts>> get wishlistSubproductsStream {
    var user = AuthService().currentUser!;
    return wishlistCollection
        .doc(user.uid)
        .snapshots()
        .map(_getwishListSubproductsfromsnapshot);
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
    var user = AuthService().currentUser!;
    return billingAddressCollection
        .doc(user.uid)
        .snapshots()
        .map(_getBillingAddress);
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
    var user = AuthService().currentUser!;

    return deliveryAddressCollection
        .doc(user.uid)
        .snapshots()
        .map(_getDeliveryAddress);
  }

  //List of ShoppingCartProduct from document snapshot
  List<ShoppingCartProduct> _getShoppingCartProductsfromSnapshot(
      DocumentSnapshot documentSnapshot) {
    return documentSnapshot.data().toString().contains('shoppingcart')
        ? (documentSnapshot.get('shoppingcart') as List).map((product) {
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
          }).toList()
        : const [];
  }

  //Get shoppingcart Stream from firestore
  Stream<List<ShoppingCartProduct>> get shoppingCartProductStream {
    var user = AuthService().currentUser!;
    return shoppingcartCollection
        .doc(user.uid)
        .snapshots()
        .map(_getShoppingCartProductsfromSnapshot);
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
    };

    var user = AuthService().currentUser!;
    await wishlistCollection.doc(user.uid).update({
      'subproducts': FieldValue.arrayRemove([nestedData])
    });
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
    await shoppingcartCollection.doc(user.uid).update({
      'shoppingcart': FieldValue.arrayRemove([nestedData])
    });
  }

  ///Checks

  //Check SubProducts item on wishlist on firestore wishlist collection
  Future<bool> checkItem({required SubProducts subproduct}) async {
    bool isWishlisted = false;
    var subList = [];

    var user = AuthService().currentUser!;
    var ref = wishlistCollection.doc(user.uid);

    await ref.get().then((value) {
      value.data().toString().contains('subproducts')
          ? (value.get('subproducts') as List).forEach((element) {
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
            })
          : false;
    });
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

    await ref.get().then((value) {
      value.data().toString().contains('shoppingcart')
          ? (value.get('shoppingcart') as List).forEach((element) {
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
            })
          : false;
    });
    subList = [];
    return isWishlisted;
  }
}
