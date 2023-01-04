import 'package:attendance_manager/providers/teacher.dart';
import 'package:attendance_manager/resources/auth_methods.dart';
import 'package:attendance_manager/screens/student_screens/all_subjects_screen.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/screens/student_screens/student_calendar_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/all_classes_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/attendance_marking_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/students_list_screen.dart';
import 'package:attendance_manager/screens/teacher_screens/teacher_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TeacherProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => FlutterNativeSplash.remove());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthMethods().CheckLogin(),
        builder: (context,authResult){
          if(authResult.data=="student"){
            return AllSubjectsScreen();
          }
          if(authResult.data=="teacher"){

            return AllClassesScreen();
          }
          return LoginScreen();
        },
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        LoginScreen.routeName:(ctx)=>LoginScreen(),
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
