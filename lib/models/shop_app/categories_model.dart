class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    // الداتا مش هتبقي جيسون داتا كده علشان هي اوبجيكت ف ده هيتحط في النيمد كونستراكتور بتاع الداتا اللي تحت ده
    //  data = json['data'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = (json['data'] as List<dynamic>?)
            ?.map((element) => DataModel.fromJson(element))
            .toList() ??
        [];
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
