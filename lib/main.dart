import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmay/auth_wrapper.dart';
import 'package:tmay/utils/colors_utils.dart';

import 'models/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMAY App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: Center(
          child: SpinKitSpinningLines(
            color: hexStringToColor("#f369a2"),
          ),
        ),
        child: const AuthWrapper(),
      ),
    );
  }
}
