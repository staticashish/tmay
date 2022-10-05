import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmay/models/question_model.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({Key? key}) : super(key: key);

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {

  @override
  Widget build(BuildContext context) {
    var questions = Provider.of<List<QuestionModel>>(context);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          QuestionModel questionModel = questions[index];
          var question = questionModel.question ?? "";
          return ListTile(
            title: Text(question),
          );
        });
  }
}
