import 'dart:convert';
import 'package:attendance_manager/widgets/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllSubjectsScreen extends StatefulWidget {
  static const routeName = '/all-subjects-screen';
  const AllSubjectsScreen({Key? key}) : super(key: key);

  @override
  State<AllSubjectsScreen> createState() => _AllSubjectsScreenState();
}

class _AllSubjectsScreenState extends State<AllSubjectsScreen> {
  List _subjects = [];
  void getSubjects() async {
    var url = Uri.parse(
        "https://shivam13.pythonanywhere.com/api/student/get-student-attendance/01jst20cs036");
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
        title: const Text("All Subjects Screen"),
      ),
      body: _subjects.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) => SubjectTile(subjectData: _subjects[index]),
            ),
    );
  }
}
