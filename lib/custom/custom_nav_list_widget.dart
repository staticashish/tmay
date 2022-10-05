import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomNavListWidget extends StatefulWidget {
  final IconData icon;
  final String tileText;
  final Function() action;
  const CustomNavListWidget(
      {Key? key,
      required this.icon,
      required this.tileText,
      required this.action})
      : super(key: key);

  @override
  State<CustomNavListWidget> createState() => _CustomNavListWidgetState();
}

class _CustomNavListWidgetState extends State<CustomNavListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: hexStringToColor("#bcbcbd"),
        ))),
        child: InkWell(
          splashColor: hexStringToColor("#00a7a2"),
          onTap: widget.action,
          child: SizedBox(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    Icon(widget.icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.tileText,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const FaIcon(FontAwesomeIcons.arrowRightLong),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
