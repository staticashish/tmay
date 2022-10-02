import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_text_form_field_widget.dart';
import 'package:tmay/services/database_service.dart';
import 'package:uuid/uuid.dart';

class AddProjectScreen extends StatefulWidget {
  final Function onCreate;
  const AddProjectScreen({Key? key, required this.onCreate}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  String projectName = "";
  String projectDescription = "";
  final _formKey = GlobalKey<FormState>();
  final uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User>(context);

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Add Project",
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
                  labelText: "Enter Project name",
                  prefixIconData: FontAwesomeIcons.solidFolder,
                  onChange: (val) {
                    setState(() {
                      projectName = val;
                    });
                  },
                  onValidate: (val) {
                    if (val == "") {
                      return "Please enter a project name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormFieldWidget(
                  isPasswordField: false,
                  labelText: "Enter Project Description",
                  prefixIconData: FontAwesomeIcons.fileCirclePlus,
                  onChange: (val) {
                    setState(() {
                      projectDescription = val;
                    });
                  },
                  onValidate: (val) {
                    if (val == "") {
                      return "Please enter a project description";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButtonWidget(
                  labelText: "Add Project",
                  onPressed: () async {
                    String projectId = uuid.v1();
                    if (_formKey.currentState!.validate()) {
                      await widget.onCreate(
                        projectId,
                        projectName,
                        projectDescription,
                        user.uid,
                      );
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
