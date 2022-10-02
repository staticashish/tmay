import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String? Function(String? val) onValidate;
  final Function(String val) onChange;
  final String labelText;
  final bool isPasswordField;
  final int? maxLines;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Function()? toggleSuffix;

  const CustomTextFormFieldWidget(
      {Key? key,
      required this.onValidate,
      required this.onChange,
      required this.labelText,
      required this.isPasswordField,
      this.prefixIconData,
      this.suffixIconData,
      this.toggleSuffix,
      this.maxLines})
      : super(key: key);

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.onValidate,
      onChanged: widget.onChange,
      obscureText: widget.isPasswordField,
      textAlign: TextAlign.left,
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FaIcon(
            widget.prefixIconData,
            color: hexStringToColor("#bcbcbd"),
            size: 20.0,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.toggleSuffix!();
          },
          icon: FaIcon(
            widget.suffixIconData,
            color: hexStringToColor("#bcbcbd"),
            size: 20.0,
          ), //Icons.remove_red_eye_rounded),
        ),
        labelText: widget.labelText,
        labelStyle:
            TextStyle(color: hexStringToColor("#bcbcbd"), fontSize: 15.0),
      ),
    );
  }
}
