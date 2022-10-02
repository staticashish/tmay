import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  String? key;
  final String? projectId;
  final String? projectName;
  final String? projectDescription;
  Timestamp? createdAt;
  //List cabinets;

  ProjectModel(this.projectId, this.projectName, this.projectDescription);

  ProjectModel.fromSnapshot(DocumentSnapshot? snapshot)
      : key = snapshot?.id,
        projectId = (snapshot!.data()! as Map<String, dynamic>)["projectId"],
        projectName = (snapshot!.data()! as Map<String, dynamic>)["projectName"],
        projectDescription = (snapshot!.data()! as Map<String, dynamic>)["projectDescription"],
        createdAt = (snapshot!.data()! as Map<String, dynamic>)["createdAt"];

  toJson() {
    return {
      "projectName": projectName,
      "projectId": projectId,
      "projectDescription": projectDescription,
      "createdAt": FieldValue.serverTimestamp()
    };
  }
}
