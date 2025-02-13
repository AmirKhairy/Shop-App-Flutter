import 'item.dart';

class PaypalItmeListModel {
  List<Item>? items;

  PaypalItmeListModel({this.items});

  factory PaypalItmeListModel.fromJson(Map<String, dynamic> json) {
    return PaypalItmeListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
