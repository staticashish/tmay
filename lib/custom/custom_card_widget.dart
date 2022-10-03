import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 15,
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
    );
  }
}
