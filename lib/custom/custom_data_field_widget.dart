import 'package:flutter/material.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomDataFieldWidget extends StatelessWidget {
  final String titleText;
  final String valueText;

  const CustomDataFieldWidget({Key? key, required this.titleText, required this.valueText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          titleText,
          style: TextStyle(
            color: hexStringToColor("#79787a"),
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          valueText,
          style: TextStyle(
            fontSize: 20,
            color: hexStringToColor("#3a393f"),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
