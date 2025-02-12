import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Shared/cache_helper.dart';

double width(context) => MediaQuery.sizeOf(context).width;

double height(context) => MediaQuery.sizeOf(context).height;

Color defualLightColor = const Color.fromARGB(255, 249, 89, 0);

Color defualtDarkColor = const Color.fromARGB(255, 35, 59, 93);

String LOGIN = 'login';

String REGISTER = 'register';

String HOME = 'home';

String CATIGORIES = 'categories';

String FAVORITES = 'favorites';

String PROFILE = 'profile';

String UPDATE_PROFILE = 'update-profile';

String SEARCH = 'products/search';

String LOGOUT = 'logout';

String PRODUCT_DETAILS = 'products';

String CARTS = 'carts';

String UpdateCart = 'carts/';

String token = CacheHelper.getData(key: 'token');

void showToast({
  required String msg,
  required Color color,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
