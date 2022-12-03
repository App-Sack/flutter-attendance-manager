import 'package:attendance_manager/screens/student_screens/all_subjects_screen.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/screens/student_screens/subject_calendar_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/all_classes_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/single_class_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/students_list_screen.dart';
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
      home: AllClassesScreen(),
      routes: {
        SubjectCalendarScreen.routeName: (ctx) => SubjectCalendarScreen(),
        AllSubjectsScreen.routeName: (ctx) => AllSubjectsScreen(),
        AllClassesScreen.routeName:(ctx)=>AllClassesScreen(),
        SingleClassScreen.routeName:(ctx)=>SingleClassScreen(),
        StudentsListScreen.routeName:(ctx)=>StudentsListScreen(),
      },
    );
  }
}
