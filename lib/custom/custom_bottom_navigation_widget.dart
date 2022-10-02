import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomBottomNavigationWidget extends StatefulWidget {
  final int? index;
  final Function(int?) onTapFunction;
  const CustomBottomNavigationWidget(
      {Key? key, required this.index, required this.onTapFunction})
      : super(key: key);

  @override
  State<CustomBottomNavigationWidget> createState() => _CustomBottomNavigationWidgetState();
}

class _CustomBottomNavigationWidgetState extends State<CustomBottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index!,
      backgroundColor: hexStringToColor("#fefefe"),
      elevation: 50,
      selectedItemColor: hexStringToColor("#00a7a2"),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: widget.onTapFunction,
      type: BottomNavigationBarType.fixed,
      iconSize: 40,
      items: <BottomNavigationBarItem>[
        buildBottomNavigationBarItem(FontAwesomeIcons.house, "Home"),
        buildBottomNavigationBarItem(FontAwesomeIcons.solidUser, "Profile"),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: FaIcon(iconData),
      label: text,
    );
  }
}
