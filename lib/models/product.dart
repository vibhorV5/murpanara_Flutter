class Product {
  final String name;
  final List<SubProducts> subproducts;

  Product({
    this.name = '',
    this.subproducts = const [],
  });
}

class SubProducts {
  final String productId;
  final String name;
  final String imagefront;
  final String imageback;
  final String fit;
  final String composition;
  final num price;
  final List size;
  final num quantity;
  final String status;

  SubProducts({
    this.productId = '',
    this.name = '',
    this.imagefront = 'assets/images/default_mpr_eye.png',
    this.imageback = 'assets/images/default_mpr_eye.png',
    this.price = 0.00,
    this.fit = '',
    this.composition = '',
    this.size = const [],
    this.quantity = 1,
    this.status = '',
  });
}
