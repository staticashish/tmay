import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmay/models/project_model.dart';

class DatabaseService {
  final String? docId;
  final String? uid;

  DatabaseService({this.docId, required this.uid});

  final _db = FirebaseFirestore.instance;

  CollectionReference _getUserCollectionReference() {
    return _db.collection('user');
  }

  CollectionReference _getProjectCollectionReference() {
    return _getUserCollectionReference().doc(uid).collection('project');
  }

  Future addProjectRoomData(ProjectModel projectModel) async {
    _getProjectCollectionReference().add(projectModel.toJson()).then((value) {
      return value.id;
    });
  }

  Future updateUserData(String displayName, String email) async {
    _getUserCollectionReference().doc(uid).set({
      'displayName': displayName,
      'email': email,
    });
  }

  Future updateProjectData(Map<String, dynamic> data) async {
    _getProjectCollectionReference().doc(docId).update(data);
  }

  List<ProjectModel> _projectListFromSnapshot(QuerySnapshot snapshot) {
    print("help${snapshot.docs.length}");
    return snapshot.docs!.map((doc) {
      print("in...");
      return ProjectModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<ProjectModel>> get projects {
    return _getProjectCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_projectListFromSnapshot);
  }

}