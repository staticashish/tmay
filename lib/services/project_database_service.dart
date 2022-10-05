import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/services/database_service.dart';

class ProjectDatabaseService extends DatabaseService {
  ProjectDatabaseService({required super.uid, super.projectId});

  CollectionReference getProjectCollectionReference() {
    return getUserCollectionReference().doc(uid).collection('project');
  }

  Future addProjectData(ProjectModel projectModel) async {
    getProjectCollectionReference().add(projectModel.toJson()).then((value) {
      return value.id;
    });
  }

  Future updateProjectData(Map<String, dynamic> data) async {
    getProjectCollectionReference().doc(projectId).update(data);
  }

  List<ProjectModel> _projectListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs!.map((doc) {
      return ProjectModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<ProjectModel>> get projects {
    return getProjectCollectionReference()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_projectListFromSnapshot);
  }
}