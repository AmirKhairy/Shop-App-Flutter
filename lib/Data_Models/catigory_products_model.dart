class CategoryProductsModel {
  bool? status;
  Null message;
  CategoryProductsData? data;

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? CategoryProductsData.fromJson(json['data'])
        : null;
  }
}

class CategoryProductsData {
  int? currentPage;
  List<CategoryProductsDataData>? data;
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

  CategoryProductsData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CategoryProductsDataData>[];
      json['data'].forEach((v) {
        data!.add(CategoryProductsDataData.fromJson(v));
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

class CategoryProductsDataData {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  CategoryProductsDataData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
