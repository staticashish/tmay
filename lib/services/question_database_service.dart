import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/services/project_database_service.dart';

class QuestionDatabaseService extends ProjectDatabaseService {
  QuestionDatabaseService({required super.uid, String? questionId, super.projectId});

  CollectionReference getQuestionCollectionReference() {
    return getProjectCollectionReference().doc(projectId).collection("question");
  }

  Future addQuestionData(QuestionModel questionModel) async {
    getQuestionCollectionReference().add(questionModel.toJson()).then((value) {
      return value.id;
    });
  }

  Future updateQuestionData(Map<String, dynamic> data) async {
    getQuestionCollectionReference().doc(questionId).update(data);
  }

  List<QuestionModel> _questionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs!.map((doc) {
      return QuestionModel.fromSnapshot(doc);
    }).toList();
  }

  Stream<List<QuestionModel>> get questions {

    return getQuestionCollectionReference()
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(_questionListFromSnapshot);
  }
}