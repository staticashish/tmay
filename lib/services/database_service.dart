import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  final String? projectId;
  final String? questionId;

  DatabaseService({this.projectId, this.questionId, this.uid});

  final db = FirebaseFirestore.instance;

  CollectionReference getUserCollectionReference() {
    return db.collection('user');
  }

  Future updateUserData(String displayName, String email) async {
    getUserCollectionReference().doc(uid).set({
      'displayName': displayName,
      'email': email,
    });
  }

}