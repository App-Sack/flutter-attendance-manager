import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CieStudent {
  final String course_id;
  final int? e1;
  final int? e2;
  final int? e3;
  final int? e4;
  final int? e5;

  CieStudent(this.course_id, this.e1, this.e2, this.e3, this.e4, this.e5);
}

class CieStudentProvider with ChangeNotifier {
  List<CieStudent> cieStudentData = [];
  Future fetchAndSetCieStudentData(String usn) async {
    List cieStudentData = [];
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/cie/get-students-all-courses-cie/$usn/");
    var data = await http.get(url);
    final extractedData = json.decode(data.body);
    final cieExtractedData = (extractedData['cie_data']);
    for (var cieData in cieExtractedData) {
      print(cieData);
    }
  }
}
