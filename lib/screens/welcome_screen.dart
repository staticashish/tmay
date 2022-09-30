import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/wrapper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return StreamProvider<User?>.value(
      value: authService.currentUser,
      initialData: null,
      child: const Wrapper(),
    );
  }
}
