import 'product.dart';

class Data {
  int? id;
  int? quantity;
  Product? product;

  Data({this.id, this.quantity, this.product});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        quantity: json['quantity'] as int?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'product': product?.toJson(),
      };
}
