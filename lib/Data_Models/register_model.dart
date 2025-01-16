class RegisterModel {
  bool status;
  String message;
  RegisterModelData? data;

  RegisterModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = json['data'] != null
            ? RegisterModelData.fromJson(json['data'])
            : null;
}

class RegisterModelData {
  String name;
  String phone;
  String email;
  int id;
  String image;
  String token;

  RegisterModelData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        id = json['id'],
        image = json['image'],
        token = json['token'];
}
