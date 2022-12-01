import 'package:attendance_manager/screens/login_screen.dart';
import 'package:attendance_manager/screens/all_subjects_screen.dart';
import 'package:attendance_manager/screens/subject_calendar_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        AllSubjectsScreen.routeName:(ctx)=>AllSubjectsScreen(),
        SubjectCalendarScreen.routeName:(ctx)=>SubjectCalendarScreen(),
      },
    );
  }
}
