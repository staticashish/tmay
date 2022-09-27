import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmay/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      return const Text("User is logged in");
    } else {
      return const Authenticate();
    }
  }
}
