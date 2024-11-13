import 'package:flutter/material.dart';
import 'package:leaf_it/Analytics/AnalyticsTab.dart';
import 'package:leaf_it/Controller/ControllerTab.dart';
import 'package:leaf_it/HomeScreen/Homescreen.dart';
import 'package:leaf_it/MainTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeafIT',
      theme: MainTheme.lightMode,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        ControllerTab.routeName: (context) => ControllerTab(),
        AnalyticsTab.routeName: (context) => AnalyticsTab(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
