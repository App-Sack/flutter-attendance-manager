import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Student{
  final String name;
  final String usn;
  final double percentage;
  final int present;
  final int totalClasses;

  Student({required this.name,required this.usn,required this.percentage,required this.present,required this.totalClasses});
}

class StudentProvider with ChangeNotifier{
  List<Student> students=[];
  String courseId='';

  Future fetchAndSetStudents(String section,String subId) async{
      students=[];
      var url=Uri.parse("https://sjce12345.pythonanywhere.com/api/teacher/get-students-in-section/$section/$subId/");
      var response=await http.get(url);
      var responseData=json.decode(response.body);
      var assignedClasses=responseData['studentsData'];
      courseId=responseData['course_id'];
      for (var element in assignedClasses) {
        Student newStudent=Student(usn: element['usn'],name: element['name'],present: element['total_present'],totalClasses: element['total_classes'],percentage: double.parse(element['attendance_percentage'].toString()));
        students.add(newStudent);
      }
  }

  List<Student> get studentsList{
    return [...students];
  }
}