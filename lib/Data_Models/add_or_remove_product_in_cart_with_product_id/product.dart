class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  Product({this.id, this.price, this.oldPrice, this.discount, this.image});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        price: json['price'] as int?,
        oldPrice: json['old_price'] as int?,
        discount: json['discount'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'image': image,
      };
}
