class GetProfileModel {
  bool status;
  GetProfileDataModel? data;

  GetProfileModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = json['data'] != null
            ? GetProfileDataModel.fromJson(json['data'])
            : null;
}

class GetProfileDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;
  GetProfileDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        image = json['image'],
        points = json['points'],
        credit = json['credit'],
        token = json['token'];
}
