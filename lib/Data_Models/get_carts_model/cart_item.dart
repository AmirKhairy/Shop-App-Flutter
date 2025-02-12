import 'product.dart';

class CartItem {
	int? id;
	int? quantity;
	Product? product;

	CartItem({this.id, this.quantity, this.product});

	factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
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
