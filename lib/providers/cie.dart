import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CIE {
  final String course_id;
  final String usn;
  final String student_name;
  final int? e1;
  final int? e2;
  final int? e3;
  final int? e4;
  final int? e5;

  CIE(
      {required this.course_id,
      required this.student_name,
      required this.usn,
      required this.e1,
      required this.e2,
      required this.e3,
      required this.e4,
      required this.e5});
}

class CieProvider with ChangeNotifier {
  List<CIE> cieData = [];
  Future fetchAndSetCieData(String section, String courseId) async {
    cieData = [];
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/cie/get-students-in-section-cie/$section/$courseId/");
    var data = await http.get(url);
    final extractedData = json.decode(data.body);
    print(extractedData);
    String course_id = extractedData["course_id"];
    final studentsData = extractedData["students_data"];
    for (var student in studentsData) {
      CIE newCie = CIE(
          course_id: course_id,
          student_name: student["name"],
          usn: student["usn"],
          e1: student["e1"],
          e2: student["e2"],
          e3: student["e3"],
          e4: student["e4"],
          e5: student["e5"]);
      cieData.add(newCie);
    }
  }

  List<CIE> get CieData {
    return [...cieData];
  }

  Future<String> updateCie(Map<String, dynamic> dataToSend) async {
    String message = "";
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    var url = Uri.parse(
        "http://sjce12345.pythonanywhere.com/api/cie/update-student-cie/");
    var response =
        await http.post(url, body: json.encode(dataToSend), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    });
    message = json.decode(response.body);
    if (message.contains("Successful")) {
      notifyListeners();
      return "Successful";
    } else {
      return message;
    }
  }
}
