import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _attendanceData=[];
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
    notifyListeners();
  }

  List<dynamic> getAttendanceData() {
    return [..._attendanceData];
  }

  void clearAttendance(String deleteDate,String usn,String courseId){
    _attendanceData.forEach((element) async {
      String parseDate=DateFormat('dd-MM-yyyy').format(DateTime.parse(element.date));

      //Compare dates in the form dd-MM-yyyy
      if(parseDate==deleteDate){
        SharedPreferences sp=await SharedPreferences.getInstance();
        String? token=sp.getString('token');
        //To send the date in the format yyyy-MM-dd
        parseDate=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.date));
          var url=Uri.parse("https://sjce12345.pythonanywhere.com/api/teacher/reset-attendance-on-date");
          Map<String,dynamic> dataToSend={"course_id":courseId,"usn":usn,"date":parseDate};
          var response=await http.post(url,body:
            json.encode(dataToSend)
          ,headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Token $token',
          });
        String message=json.decode(response.body);
        if(message=="Successful"){
          notifyListeners();
        }
      }
    });
  }
}
