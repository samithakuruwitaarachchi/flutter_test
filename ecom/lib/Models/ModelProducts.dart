class Product {
  final String name;
  final String image;
  final String price;
  final String discount_price;
  final String code;
  final String shortDescription;
  final String product_code;
  final String price_currency;



  const Product({
    required this.name,
    required this.image,
    required this.price,
    required this.discount_price,
    required this.code,
    required this.shortDescription,
    required this.product_code,
    required this.price_currency,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['images'].url,
      price: json['price'],
      discount_price: json['discount_price'],
      code:  json['code'],
      shortDescription: json['shortDescription'],
      product_code: json['product_code'],
      price_currency: json['price_currency'],

    );
  }
}