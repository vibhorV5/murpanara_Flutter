import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:murpanara/models/app_user.dart';
import 'package:murpanara/models/product.dart';
import 'package:murpanara/models/subproducts.dart';
import 'package:murpanara/services/auth.dart';

class DatabaseServices {
  final String? uid;

  DatabaseServices({this.uid});

  final userCurrent = AuthService().currentUser;

  FirebaseFirestore _db = FirebaseFirestore.instance;

// Collection Reference for products
  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

// Collection Reference for subproducts
  CollectionReference subproductsCollection =
      FirebaseFirestore.instance.collection('subproducts');

//Collection Reference for wishlist
  CollectionReference wishlistCollection =
      FirebaseFirestore.instance.collection('wishlist');

  ///FETCHING DATA
// List of Products from Snapshot
  List<Product> _getProductsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        // subproducts: doc.data().toString().contains('subproducts')
        //     ? doc.get('subproducts')
        //     : const [],
        subproducts: doc.data().toString().contains('subproducts')
            ? (doc.get('subproducts') as List)
                .map(
                  (product) => SubProducts(
                    name: product['name'],
                    imagefront: product['imagefront'],
                    imageback: product['imageback'],
                    fit: product['fit'],
                    composition: product['composition'],
                    price: product['price'],
                  ),
                )
                .toList()
            : const [],
        name: doc.data().toString().contains('name') ? doc.get('name') : '',
      );
    }).toList();
  }

  List<SubproductsMain> _getSubproductsMainFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SubproductsMain(
        name: doc.data().toString().contains('name') ? doc.get('name') : '',
        fit: doc.data().toString().contains('fit') ? doc.get('fit') : '',
        composition: doc.data().toString().contains('composition')
            ? doc.get('composition')
            : '',
        imagefront: doc.data().toString().contains('imagefront')
            ? doc.get('imagefront')
            : '',
        imageback: doc.data().toString().contains('imageback')
            ? doc.get('imageback')
            : '',
        price: doc.data().toString().contains('name') ? doc.get('price') : 0.0,
      );
    }).toList();
  }

// Get Products Stream
  Stream<List<Product>> get productsStream {
    return productsCollection.snapshots().map(_getProductsFromSnapshot);
  }

  //Get SubProducts Stream
  Stream<List<SubproductsMain>> get subproductsStream {
    return subproductsCollection
        .snapshots()
        .map(_getSubproductsMainFromSnapshot);
  }

  ///SETTING DATA
//
  Future setWishlistItemOnFirestore() async {
    final city = <String, String>{
      "name": "Los Angeles",
      "state": "CA",
      "country": "USA"
    };
    await wishlistCollection.doc(userCurrent!.uid).set(city);
  }
}
