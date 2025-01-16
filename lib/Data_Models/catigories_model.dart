class CatigoriesModel {
  bool status;
  CatigoriesDataModel data;

  CatigoriesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = CatigoriesDataModel.fromJson(json['data']);
}

class CatigoriesDataModel {
  List<CatigoriesDataDataModel> data = [];

  CatigoriesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(CatigoriesDataDataModel.fromJson(element));
    });
  }
}

class CatigoriesDataDataModel {
  int id;
  String name;
  String image;

  CatigoriesDataDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];
}
