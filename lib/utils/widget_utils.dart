import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(imageName,
      fit: BoxFit.fitWidth, width: 300, height: 300);
}