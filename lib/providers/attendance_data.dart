import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceData {
  final int id;
  final String date;
  final bool isPresent;

  AttendanceData(
      {required this.id, required this.date, required this.isPresent});
}

class AttendanceDataProvider with ChangeNotifier {
  List<AttendanceData> _attendanceData = [];
  Future fetchAndSetAttendanceData(String usn, String courseId) async {
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/student/get-calendar-attendance/$usn/$courseId/");
    var data = await http.get(url);
    final extractedData = json.decode(data.body) as List<dynamic>;
    extractedData.forEach((element) {
      AttendanceData newAttendanceData = AttendanceData(
          id: element['id'],
          date: element['date'],
          isPresent: element['isPresent']);
      _attendanceData.add(newAttendanceData);
    });
  }

  List<dynamic> getAttendanceData() {
    return [..._attendanceData];
  }
}
