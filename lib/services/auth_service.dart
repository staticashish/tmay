import 'package:firebase_auth/firebase_auth.dart';
import 'package:tmay/models/firebase_result.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get currentUser {
    return _auth.authStateChanges();
  }

  FirebaseResult _firebaseResultFromResponse(User? user, String? error) {
    return user != null ? FirebaseResult(user, null) : FirebaseResult(null, error);
  }

  /*
      Register user with email and password.
   */
  Future registerWithEmailAndPassword(String email, String password, String firstName, String lastName) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => null);
      User? user  = _auth.currentUser;
      user?.updateDisplayName("$firstName $lastName");
      /*await DatabaseService(docId: user?.uid)
          .updateUserData(name, user?.email);*/
      return _firebaseResultFromResponse(user!, null);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return _firebaseResultFromResponse(null, e.message);
    }
  }

  /*
      Sign-in user with email and password.
   */
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _firebaseResultFromResponse(userCredential.user, null);
    } on FirebaseAuthException catch (e){
      print(e.toString());
      return _firebaseResultFromResponse(null, e.message);
    }
  }

  /*
    Sign-out user
   */
  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e){
      print(e.toString());
      return _firebaseResultFromResponse(null, e.message);
    }
  }
}