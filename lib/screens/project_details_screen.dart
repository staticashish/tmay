import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/screens/add_question_screen.dart';
import 'package:tmay/screens/project_information_screen.dart';
import 'package:tmay/screens/question_list_screen.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/services/question_database_service.dart';
import 'package:tmay/utils/colors_utils.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel projectModel;
  const ProjectDetailsScreen({Key? key, required this.projectModel})
      : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  AuthService authService = AuthService();

  void _showQuestionAdd() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamProvider<User?>.value(
              initialData: authService.currentUser,
              value: authService.userStream,
              child: AddQuestionScreen(
                projectModel: widget.projectModel,
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<QuestionModel>>.value(
            initialData: [],
            value: QuestionDatabaseService(
                    uid: user?.uid, projectId: widget.projectModel.key!)
                .questions),
      ],
      child: Scaffold(
        appBar: CustomAppBarWidget(
          title: "Project Details",
          searchDelegate: null,
          isSubPage: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: hexStringToColor("#fd9333"),
          child: const FaIcon(FontAwesomeIcons.squarePlus),
          onPressed: () {
            _showQuestionAdd();
          },
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              10, MediaQuery.of(context).size.height * 0.02, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Basic Information",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: hexStringToColor("#f369a2"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ProjectInformationScreen(projectModel: widget.projectModel),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Questions",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: hexStringToColor("#f369a2"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const QuestionListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
