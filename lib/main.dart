import 'package:enext/pages/education.page.dart';
import 'package:enext/pages/courses.page.dart';
import 'package:enext/pages/login.page.dart';
import 'package:enext/pages/main.page.dart';
import 'package:flutter/material.dart';
import './pages/courses.page.dart';

void main() => runApp(EnextApp());

class EnextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENEXT.Study',
      debugShowCheckedModeBanner: false,
      home: EducationPage( ),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        accentColor: Colors.white70
      ),
      routes: {
        CoursesPage.routeName: (context) => CoursesPage(),
        EducationPage.routeName: (context) => EducationPage(),
      },
    );
  }
}