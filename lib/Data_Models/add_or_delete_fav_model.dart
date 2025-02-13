class AddOrDeleteFavModel {
  bool? status;
  String? message;
  Data? data;

  AddOrDeleteFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  Product? product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  Product.fromJson(Map<String, dynamic> json) {
    id = (json['id'] is double) ? json['id'].toInt() : json['id'];
    price = (json['price'] is double) ? json['price'].toInt() : json['price'];
    oldPrice = (json['old_price'] is double)
        ? json['old_price'].toInt()
        : json['old_price'];
    discount = (json['discount'] is double)
        ? json['discount'].toInt()
        : json['discount'];
    image = json['image'];
  }
}
