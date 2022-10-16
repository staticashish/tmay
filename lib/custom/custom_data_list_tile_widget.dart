import 'package:flutter/material.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomDataListTileWidget extends StatefulWidget {
  final String? question;
  const CustomDataListTileWidget({Key? key, required this.question})
      : super(key: key);

  @override
  State<CustomDataListTileWidget> createState() => _CustomDataListTileWidgetState();
}

class _CustomDataListTileWidgetState extends State<CustomDataListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      elevation: 5,
      shadowColor: hexStringToColor("#00a7a2"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.question!,
                style: TextStyle(
                  fontSize: 15,
                  color: hexStringToColor("#3a393f"),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
