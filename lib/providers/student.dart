import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Student{
  final String name;
  final String usn;
  final double percentage;

  Student({required this.name,required this.usn,required this.percentage});
}

class StudentProvider with ChangeNotifier{
  List<Student> students=[];

  Future fetchAndSetStudents(String section,String courseId) async{
      students=[];
      var url=Uri.parse("https://sjce12345.pythonanywhere.com/api/teacher/get-students-in-section/$section/$courseId/");
      var response=await http.get(url);
      var responseData=json.decode(response.body);
      for (var element in responseData) {
        Student newStudent=Student(usn: element['usn'],name: element['name'],percentage: double.parse(element['attendance_percentage'].toString()));
        students.add(newStudent);
      }
  }

  List<Student> get studentsList{
    return [...students];
  }
}