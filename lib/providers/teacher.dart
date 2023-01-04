import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Teacher {
  final String teacherId;
  final String name;
  final List<dynamic> assignedClasses;

  Teacher(this.teacherId, this.name, this.assignedClasses);
}

class TeacherProvider {
  var responseData;
  Teacher teacher = Teacher("teacherId", "name", []);
  void fetchAndSetTeacher() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/teacher/get-teacher-details/test@sjce.in/");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer 2d7188e0baacce98017bbfff0a63c9253b43dcc5',
    });
    //print(response.body);
    responseData = json.decode(response.body);
    print(responseData['assignedClasses']);
    //print(responseData);
    teacher = Teacher(responseData['id'], responseData['name'],
        responseData['assignedClasses']);
  }

  List<dynamic> getClasses() {
    return [
      {"section": "B5", "course": "Principles of Compilers"},
      {"section": "C5", "course": "Principles of Compilers"}
    ];
  }
}
