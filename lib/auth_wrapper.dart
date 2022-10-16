import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmay/authenticate.dart';
import 'package:tmay/screens/start_screen.dart';
import 'package:tmay/services/auth_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return StreamBuilder(
        stream: authService.userStream,
        // If the user is already signed-in, use it as initial data
        initialData: authService.currentUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const StartScreen();
           }
          return const Authenticate();
        });
  }
}
