import 'data.dart';

class GetCartsModel {
  bool? status;
  dynamic message;
  Data? data;

  GetCartsModel({this.status, this.message, this.data});

  factory GetCartsModel.fromJson(Map<String, dynamic> json) => GetCartsModel(
        status: json['status'] as bool?,
        message: json['message'] as dynamic,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
