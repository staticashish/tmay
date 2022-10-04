import 'package:flutter/material.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_data_field_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/screens/project_information_screen.dart';
import 'package:tmay/utils/colors_utils.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel projectModel;
  const ProjectDetailsScreen({Key? key, required this.projectModel})
      : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Project Details",
        searchDelegate: null,
        isSubPage: true,
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
                  "Project Information",
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
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
