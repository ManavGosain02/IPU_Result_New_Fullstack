import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ipu_results/pages/homepage.dart';

import 'package:ipu_results/widgets/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme(context),
      home: HomePage(),
    );
  }
}
