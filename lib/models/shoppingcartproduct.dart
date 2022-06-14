class ShoppingCartProduct {
  final String productId;
  final String name;
  final String imagefront;
  final String imageback;
  final String fit;
  final String composition;
  final num price;
  final String size;
  final num quantity;

  ShoppingCartProduct({
    this.productId = '',
    this.name = '',
    this.imagefront = '',
    this.imageback = '',
    this.price = 0.00,
    this.fit = '',
    this.composition = '',
    this.size = '',
    this.quantity = 1,
  });
}
