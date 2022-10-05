import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  bool? isSubPage;
  final SearchDelegate? searchDelegate;

  CustomAppBarWidget(
      {Key? key, required this.title, this.searchDelegate, this.isSubPage})
      : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: hexStringToColor("#00a7a2"),
      leading: Builder(
        builder: (BuildContext context) {
          if (widget.isSubPage != null && widget.isSubPage == true) {
            return IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeftLong),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          } else {
            return IconButton(
              icon: const FaIcon(FontAwesomeIcons.barsStaggered),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }
        },
      ),
      elevation: 10,
      iconTheme: IconThemeData(
        color: hexStringToColor("#fefefe"),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: hexStringToColor("#fefefe"),
        ),
      ),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          onPressed: () {
            showSearch(
              context: context,
              delegate: widget.searchDelegate!,
            );
          },
        ),
      ],
    );
  }
}
