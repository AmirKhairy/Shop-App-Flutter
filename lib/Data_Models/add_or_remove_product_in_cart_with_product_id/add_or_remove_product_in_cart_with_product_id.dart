import 'data.dart';

class AddOrRemoveProductInCartWithProductId {
  bool? status;
  String? message;
  Data? data;

  AddOrRemoveProductInCartWithProductId({
    this.status,
    this.message,
    this.data,
  });

  factory AddOrRemoveProductInCartWithProductId.fromJson(
      Map<String, dynamic> json) {
    return AddOrRemoveProductInCartWithProductId(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
