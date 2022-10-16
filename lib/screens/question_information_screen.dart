import 'package:flutter/material.dart';
import 'package:tmay/custom/custom_data_field_widget.dart';
import 'package:tmay/models/question_model.dart';

class QuestionInformationScreen extends StatelessWidget {
  final QuestionModel questionModel;
  const QuestionInformationScreen({Key? key, required this.questionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDataFieldWidget(
          titleText: "Question",
          valueText: questionModel.question!,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
