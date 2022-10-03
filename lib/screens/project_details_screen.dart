import 'package:flutter/material.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_data_field_widget.dart';
import 'package:tmay/models/project_model.dart';
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
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Project Details",
        searchDelegate: null,
        isSubPage: true,
      ),
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              10, MediaQuery.of(context).size.height * 0.025, 10, 0),
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
                      color: hexStringToColor("#3a393f"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration:
                          BoxDecoration(border: Border.all(width: 0.50)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomDataFieldWidget(
                titleText: "Project Name",
                valueText: widget.projectModel.projectName!,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDataFieldWidget(
                titleText: "Project Description",
                valueText: widget.projectModel.projectDescription!,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
