import 'package:flutter/material.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomCardWidget extends StatefulWidget {
  final String cardText;
  const CustomCardWidget({Key? key, required this.cardText}) : super(key: key);

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5,
      shadowColor: hexStringToColor("#00a7a2"),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            widget.cardText!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
