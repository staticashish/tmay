import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String labelText;
  final Size? buttonSize;
  final IconData? iconData;
  const CustomElevatedButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.labelText,
      this.buttonSize,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: hexStringToColor("#fd9333"),
        shadowColor: hexStringToColor("#8685EF"),
        fixedSize: buttonSize,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if(iconData != null) Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: FaIcon(
                      iconData,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    labelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: hexStringToColor("#fefefe"),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
