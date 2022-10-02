import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmay/custom/custom_nav_list_widget.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/utils/colors_utils.dart';

class CustomLeftNavigationWidget extends StatefulWidget {
  const CustomLeftNavigationWidget({Key? key}) : super(key: key);

  @override
  State<CustomLeftNavigationWidget> createState() => _CustomLeftNavigationWidgetState();
}

class _CustomLeftNavigationWidgetState extends State<CustomLeftNavigationWidget> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      minRadius: 40,
                      maxRadius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/default_profile.jpeg',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RichText(
                      text: TextSpan(
                        text: _authService.currentUser?.displayName,
                        style: TextStyle(
                          color: hexStringToColor("#00a7a2"),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          CustomNavListWidget(icon: FontAwesomeIcons.person, tileText: "Profile", action: (){
            print('tap profile');
          }),
          CustomNavListWidget(icon: FontAwesomeIcons.gear, tileText: "Setting", action: (){
            print('tap setting');
          }),
          CustomNavListWidget(icon: FontAwesomeIcons.arrowUpRightFromSquare, tileText: "Logout", action: () async {
            print('tap logout');
            await _authService.signOut();
          }),
        ],
      ),
    );
  }
}
