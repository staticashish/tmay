import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String? Function(String? val) onValidate;
  final Function(String val) onChange;
  final String labelText;
  final bool isPasswordField;
  final IconData prefixIconData;
  final IconData? sufixIconData;

  const CustomTextFormFieldWidget({Key? key, required this.onValidate, required this.onChange, required this.labelText, required this.isPasswordField, required this.prefixIconData, required this.sufixIconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidate,
      onChanged: onChange,
      obscureText: isPasswordField,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIconData,
          color: hexStringToColor("#bcbcbd"),
        ),
        suffixIcon: Icon(
          sufixIconData,
          color: hexStringToColor("#bcbcbd"),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: hexStringToColor("#bcbcbd"),
        ),
        //filled: true,
        /*border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),*/
      ),
    );
  }
}
