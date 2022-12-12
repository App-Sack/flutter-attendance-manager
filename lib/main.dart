import 'package:attendance_manager/screens/student_screens/all_subjects_screen.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/screens/student_screens/student_calendar_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/all_classes_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/attendance_marking_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/students_list_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/teacher_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        StudentCalendarScreen.routeName: (ctx) => StudentCalendarScreen(),
        AllSubjectsScreen.routeName: (ctx) => AllSubjectsScreen(),
        AllClassesScreen.routeName:(ctx)=>AllClassesScreen(),
        StudentsListScreen.routeName:(ctx)=>StudentsListScreen(),
        AttendanceMarkingScreen.routeName:(ctx)=>AttendanceMarkingScreen(),
        TeacherCalenderScreen.routeName:(ctx)=>TeacherCalenderScreen()
      },
    );
  }
}
