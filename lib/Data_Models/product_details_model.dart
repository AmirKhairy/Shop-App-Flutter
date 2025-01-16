class ProductDetailsModel {
  bool? status;
  String? message;  
  Data? data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  double? price;  
  double? oldPrice;  
  double? discount;  
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String>? images;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = (json['price'] as num?)?.toDouble();  
    oldPrice = (json['old_price'] as num?)?.toDouble();
    discount = (json['discount'] as num?)?.toDouble();
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images']?.cast<String>();
  }
}
