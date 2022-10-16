import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/models/question_model.dart';
import 'package:tmay/screens/add_video_screen.dart';
import 'package:tmay/screens/question_information_screen.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/utils/colors_utils.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final QuestionModel questionModel;
  const QuestionDetailsScreen({Key? key, required this.questionModel})
      : super(key: key);

  @override
  State<QuestionDetailsScreen> createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  AuthService authService = AuthService();

  void _showAddVideo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamProvider<User?>.value(
            initialData: authService.currentUser,
            value: authService.userStream,
            child: AddVideoScreen(
              questionModel: widget.questionModel,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Question Details",
        searchDelegate: null,
        isSubPage: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexStringToColor("#fd9333"),
        child: const FaIcon(FontAwesomeIcons.squarePlus),
        onPressed: () {
          _showAddVideo();
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
            QuestionInformationScreen(questionModel: widget.questionModel),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Text(
                  "Videos",
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
              height: 30,
            ),
            // const QuestionListScreen(),
          ],
        ),
      ),
    );
  }
}
