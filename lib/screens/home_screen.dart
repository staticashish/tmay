import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_app_bar_widget.dart';
import 'package:tmay/custom/custom_evelated_button_widget.dart';
import 'package:tmay/custom/custom_left_navigation_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/screens/add_project_screen.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/services/database_service.dart';
import 'package:tmay/utils/colors_utils.dart';
import 'package:tmay/utils/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();

  void _showProjectAdd(uid) {
    print("context 1: " + context.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      print("context 2: " + context.toString());
      return StreamProvider<User?>.value(
          initialData: authService.currentUser,
          value: authService.userStream,
          child: AddProjectScreen(onCreate: _onCreate));
    }));
  }

  void _onCreate(
      String projectId, String projectName, String projectDesc, String uid) {
    DatabaseService databaseService = DatabaseService(uid: uid);
    ProjectModel projectModel =
        ProjectModel(projectId, projectName, projectDesc);
    databaseService.addProjectRoomData(projectModel);
    showToast("Project added", hexStringToColor("#79787a"));
  }

  @override
  Widget build(BuildContext context) {
    var projects = Provider.of<List<ProjectModel>>(context);
    User? user = Provider.of<User?>(context);
    print("projects ${projects.length}");
    return Scaffold(
      drawer: const CustomLeftNavigationWidget(),
      appBar: CustomAppBarWidget(title: "Dashboard", searchDelegate: null),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CustomScrollView(slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                print(projects.length);
                if (index == 0) {
                  return CustomElevatedButtonWidget(
                    onPressed: () {
                      print("Add Project Button Pressed !!");
                      _showProjectAdd(user?.uid);
                    },
                    labelText: "+ Add Project",
                  );
                }
                if (projects.isNotEmpty) {
                  final projectData = projects[index - 1];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 15,
                    child: Center(
                      child: Text(
                        projectData.projectName!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ),
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
