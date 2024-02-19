
class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel>? banners = [];
  List<ProductModel>? products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    banners = (json['banners'] as List<dynamic>?)
            ?.map((element) => BannersModel.fromJson(element))
            .toList() ??
        [];
    products = (json['products'] as List<dynamic>?)
            ?.map((element) => ProductModel.fromJson(element))
            .toList() ??
        [];
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
