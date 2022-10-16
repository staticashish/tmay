import 'package:flutter/material.dart';
import 'package:tmay/custom/custom_data_field_widget.dart';
import 'package:tmay/models/project_model.dart';

class ProjectInformationScreen extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectInformationScreen({Key? key, required this.projectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDataFieldWidget(
          titleText: "Project Name",
          valueText: projectModel.projectName!,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomDataFieldWidget(
          titleText: "Project Description",
          valueText: projectModel.projectDescription!,
        ),
      ],
    );
  }
}
