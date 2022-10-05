import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_text_form_field_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/services/database_service.dart';
import 'package:tmay/services/project_database_service.dart';
import 'package:tmay/services/question_database_service.dart';
import 'package:tmay/utils/widget_utils.dart';
import 'package:uuid/uuid.dart';

class AddQuestionScreen extends StatefulWidget {
  final ProjectModel projectModel;
  const AddQuestionScreen({Key? key, required this.projectModel})
      : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final uuid = const Uuid();
  String question = "";

  void _onCreate(String questionId, String question, String uid) {
    var projectKey = widget.projectModel.key;
    if(projectKey != null) {
      print("project Key while saving question =>$projectKey");
    }

    QuestionDatabaseService questionDatabaseService = QuestionDatabaseService(uid: uid, questionId: questionId, projectId: projectKey!);
    QuestionModel questionModel = QuestionModel(questionId, question);
    questionDatabaseService.addQuestionData(questionModel);
    showToast("Question added");
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User>(context);

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Add Question",
        isSubPage: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.05, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomTextFormFieldWidget(
                  isPasswordField: false,
                  labelText: "Enter Question",
                  prefixIconData: FontAwesomeIcons.question,
                  onChange: (val) {
                    setState(() {
                      question = val;
                    });
                  },
                  onValidate: (val) {
                    if (val == "") {
                      return "Please enter a question";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButtonWidget(
                  labelText: "Add Question",
                  onPressed: () async {
                    String questionId = uuid.v1();
                    if (_formKey.currentState!.validate()) {
                      _onCreate(questionId, question, user.uid);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
