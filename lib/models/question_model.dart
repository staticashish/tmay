import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? key;
  final String? questionId;
  final String? question;
  Timestamp? createdAt;
  //List cabinets;

  QuestionModel(this.questionId, this.question);

  QuestionModel.fromSnapshot(DocumentSnapshot? snapshot)
      : key = snapshot?.id,
        questionId = (snapshot!.data()! as Map<String, dynamic>)["questionId"],
        question = (snapshot!.data()! as Map<String, dynamic>)["question"],
        createdAt = (snapshot!.data()! as Map<String, dynamic>)["createdAt"];

  toJson() {
    return {
      "question": question,
      "questionId": questionId,
      "createdAt": FieldValue.serverTimestamp()
    };
  }
}
