class EditProfileModel {
  bool status;
  String message;
  EditProfileDataModel? data;

  EditProfileModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = json['data'] != null
            ? EditProfileDataModel.fromJson(json['data'])
            : null;
}

class EditProfileDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  EditProfileDataModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        image = json['image'],
        points = json['points'],
        credit = json['credit'],
        token = json['token'];
}
