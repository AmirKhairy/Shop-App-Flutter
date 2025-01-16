class GetFavoritesModel {
  bool? status;
  Null message;
  GetFavoritesData? data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? GetFavoritesData.fromJson(json['data']) : null;
  }
}

class GetFavoritesData {
  int? currentPage;
  List<GetFavoritesData2>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
  int? to;
  int? total;

  GetFavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <GetFavoritesData2>[];
      json['data'].forEach((v) {
        data!.add(GetFavoritesData2.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class GetFavoritesData2 {
  int? id;
  GetFavoritesData2Product? product;

  GetFavoritesData2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? GetFavoritesData2Product.fromJson(json['product'])
        : null;
  }
}

class GetFavoritesData2Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  GetFavoritesData2Product.fromJson(Map<String, dynamic> json) {
    id = (json['id'] is double) ? json['id'].toInt() : json['id'];
    price = (json['price'] is double) ? json['price'].toInt() : json['price'];
    oldPrice = (json['old_price'] is double)
        ? json['old_price'].toInt()
        : json['old_price'];
    discount = (json['discount'] is double)
        ? json['discount'].toInt()
        : json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
