import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmay/utils/colors_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(imageName,
      fit: BoxFit.fitWidth, width: 300, height: 300);
}

showToast(String messageText, Color toastColor) {
  Fluttertoast.showToast(
      msg: messageText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: toastColor,
      textColor: hexStringToColor("#fefefe"),
      fontSize: 15.0);
}