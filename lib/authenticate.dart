import 'package:flutter/cupertino.dart';
import 'package:tmay/screens/sign_in_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggelView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggelView);
    } else {
      return Text("Register");
      //return RegisterNew(toggleView: toggelView);
    }
  }
}
