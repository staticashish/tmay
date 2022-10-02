import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmay/custom/custom_bottom_navigation_widget.dart';
import 'package:tmay/models/project_model.dart';
import 'package:tmay/screens/home_screen.dart';
import 'package:tmay/services/auth_service.dart';
import 'package:tmay/services/database_service.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index!;
    });
  }

  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    AuthService authService = AuthService();
    User? user = authService.currentUser;

    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
            initialData: null, value: authService.userStream),
        StreamProvider<List<ProjectModel>>.value(
            initialData: [], value: DatabaseService(uid: user?.uid).projects),
      ],
      child: Scaffold(
        body: widgetOptions[_selectedIndex],
        bottomNavigationBar: CustomBottomNavigationWidget(
          index: _selectedIndex,
          onTapFunction: _onItemTapped,
        ),
      ),
    );
  }
}
