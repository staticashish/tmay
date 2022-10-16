import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_data_list_tile_widget.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/screens/question_details_screen.dart';
import 'package:tmay/services/auth_service.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({Key? key}) : super(key: key);

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  final AuthService authService = AuthService();

  void _showQuestionDetails(QuestionModel questionModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamProvider<User?>.value(
            initialData: authService.currentUser,
            value: authService.userStream,
            child: QuestionDetailsScreen(
              questionModel: questionModel,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var questions = Provider.of<List<QuestionModel>>(context);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          QuestionModel questionModel = questions[index];
          var question = questionModel.question ?? "";
          return InkWell(
            onTap: () => _showQuestionDetails(questionModel),
            child: CustomDataListTileWidget(
              question: question,
            ),
          );
          /*return ListTile(
            title: Text(question),
          );*/
        });
  }
}
