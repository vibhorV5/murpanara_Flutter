class Product {
  final String name;
  final List<SubProducts> subproducts;

  Product({
    this.name = '',
    this.subproducts = const [],
  });
}

class SubProducts {
  final String name;
  final String imagefront;
  final String imageback;
  final String fit;
  final String composition;
  final num price;

  SubProducts({
    this.name = '',
    this.imagefront = '',
    this.imageback = '',
    this.price = 0.00,
    this.fit = '',
    this.composition = '',
  });
}
