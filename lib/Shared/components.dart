import 'package:flutter/material.dart';
import 'package:shop_app/Shared/cache_helper.dart';

void navigatorTo({required context, required pageRoute}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => pageRoute,
      ),
    );

void navigatorToAndKill({required context, required pageRoute}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => pageRoute,
      ),
      (route) => false,
    );

void logOut(context, pageroute) {
  CacheHelper.remove(key: 'token').then((onValue) {
    navigatorToAndKill(context: context, pageRoute: pageroute);
  });
}

Widget horizentalSeperatorBuilder({
  required double width,
  required Color color,
}) =>
    Container(
      width: width,
      height: 1,
      color: Colors.white,
    );

Widget verticalSeperatorBuilder({
  required double height,
  required Color color,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Container(
        width: 1,
        height: height,
        color: color,
      ),
    );
