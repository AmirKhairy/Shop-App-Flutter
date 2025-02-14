import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Shared/cache_helper.dart';

double width(context) => MediaQuery.sizeOf(context).width;

double height(context) => MediaQuery.sizeOf(context).height;

Color defualLightColor = const Color.fromARGB(255, 249, 89, 0);

Color defualtDarkColor = const Color.fromARGB(255, 35, 59, 93);

String lOGIN = 'login';

String rEGISTER = 'register';

String hOME = 'home';

String cATIGORIES = 'categories';

String fAVORITES = 'favorites';

String pROFILE = 'profile';

String uPDATEPROFILE = 'update-profile';

String sEARCH = 'products/search';

String lOGOUT = 'logout';

String pRODUCTDETAILS = 'products';

String cARTS = 'carts';

String addOrDelelteItemInCart = 'carts';

String updateCart = 'carts/';

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
