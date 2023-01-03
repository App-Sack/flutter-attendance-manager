import 'dart:convert';
import 'package:attendance_manager/resources/auth_methods.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:attendance_manager/widgets/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllSubjectsScreen extends StatefulWidget {
  static const routeName = '/all-subjects-screen';
  const AllSubjectsScreen({Key? key}) : super(key: key);

  @override
  State<AllSubjectsScreen> createState() => _AllSubjectsScreenState();
}

class _AllSubjectsScreenState extends State<AllSubjectsScreen> {
  List _subjects = [];
  void getSubjects() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/student/get-student-attendance/${sp.getString('usn')}");
    var data = await http.get(url);
    final extractedData = json.decode(data.body) as List<dynamic>;
    setState(() {
      _subjects = extractedData;
    });
  }

  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subjects"),
        backgroundColor: kOrangeColor,
        actions: [
          IconButton(
              onPressed: () {
                AuthMethods().LogOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: _subjects.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) =>
                  SubjectTile(subjectData: _subjects[index]),
            ),
    );
  }
}
