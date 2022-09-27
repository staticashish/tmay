import 'package:flutter/material.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String labelText;
  const CustomElevatedButtonWidget({Key? key, required this.onPressed, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexStringToColor("#fd9333"),
        shadowColor:  hexStringToColor("#8685EF"),
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
