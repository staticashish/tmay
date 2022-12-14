import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_card_widget.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_left_navigation_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/screens/add_project_screen.dart';
import 'package:tmay/screens/project_details_screen.dart';
import 'package:tmay/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();

  void _showProjectAdd(uid) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamProvider<User?>.value(
              initialData: authService.currentUser,
              value: authService.userStream,
              child: const AddProjectScreen());
        },
      ),
    );
  }

  void _showProjectDetails(ProjectModel projectModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return StreamProvider<User?>.value(
            initialData: authService.currentUser,
            value: authService.userStream,
            child: ProjectDetailsScreen(
              projectModel: projectModel,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var projects = Provider.of<List<ProjectModel>>(context);
    User? user = Provider.of<User?>(context);

    return Scaffold(
      drawer: const CustomLeftNavigationWidget(),
      appBar: CustomAppBarWidget(title: "Dashboard", searchDelegate: null),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return CustomElevatedButtonWidget(
                    onPressed: () {
                      _showProjectAdd(user?.uid);
                    },
                    labelText: "Add Project",
                    iconData: FontAwesomeIcons.squarePlus,
                  );
                }
                if (projects.isNotEmpty) {
                  final projectData = projects[index - 1];
                  return InkWell(
                    onTap: () {
                      _showProjectDetails(projectData);
                    },
                    child: CustomCardWidget(
                      cardText: projectData.projectName!,
                    ),
                  );
                }
              },
              childCount: projects.length + 1,
            ),
          ),
        ]),
      ),
    );
  }
}
