import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Teacher {
  final String teacherId;
  final String name;
  final List<dynamic> assignedClasses;

  Teacher(this.teacherId, this.name, this.assignedClasses);
}

class TeacherProvider with ChangeNotifier{
  Teacher teacher=Teacher("teacherId", "name", []);

  Future fetchAndSetTeacher() async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    String? token=sp.getString('token');
    String? email=sp.getString('email');
    var url=Uri.parse("https://sjce12345.pythonanywhere.com/api/teacher/get-teacher-details/$email/");
    var response=await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var responseData=json.decode(response.body);
    teacher=Teacher(responseData['email'], responseData['name'], responseData['assignedClasses']);
  }

  List<dynamic> getClasses(){
    return teacher.assignedClasses;
  }
}
