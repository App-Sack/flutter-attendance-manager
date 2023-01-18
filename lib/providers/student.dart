import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Student with ChangeNotifier{
  final String name;
  final String usn;
  late double percentage;
  late int present;
  late int totalClasses;

  Student(
      {required this.name,
      required this.usn,
      required this.percentage,
      required this.present,
      required this.totalClasses});

  void markPresent(String usn){
    present=present+1;
    totalClasses=totalClasses+1;
    percentage=totalClasses!=0?(present/totalClasses)*100:10;
    notifyListeners();
  }
  void markAbsent(String usn){
    totalClasses=totalClasses+1;
    percentage=totalClasses!=0?(present/totalClasses)*100:10;
    notifyListeners();
  }
}

class StudentProvider with ChangeNotifier {
  List<Student> students = [];
  String courseId = '';

  Future fetchAndSetStudents(String section, String subId) async {
    students = [];
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/teacher/get-students-in-section/$section/$subId/");
    var response = await http.get(url);
    var responseData = json.decode(response.body);
    var assignedClasses = responseData['students_data'];
    courseId = responseData['course_id'];
    for (var element in assignedClasses) {
      Student newStudent = Student(
          usn: element['usn'],
          name: element['name'],
          present: element['total_present'],
          totalClasses: element['total_classes'],
          percentage:
              double.parse(element['attendance_percentage'].toString()));
      students.add(newStudent);
    }
    notifyListeners();
  }

  List<Student> get studentsList {
    return [...students];
  }
}
