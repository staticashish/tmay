import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/authenticate.dart';
import 'package:tmay/services/auth_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final user = Provider.of<User?>(context);
    print(user);
    if(user != null) {
      return SafeArea(
        child: Scaffold(
          body: IconButton(onPressed: (){
            print("logout");
            authService.signOut();
          }, icon: const FaIcon(FontAwesomeIcons.xmark),),
        ),
      );
    } else {
      return const Authenticate();
    }
  }
}
