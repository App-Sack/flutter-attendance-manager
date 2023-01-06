import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CIE {
  final String course_id;
  final List<Map<String, dynamic>> students_data;

  CIE({required this.course_id, required this.students_data});
}

class CieProvider with ChangeNotifier {
  List<CIE> _cieData = [];
  void fetchAndSetCieData(String section, String courseId) async {
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/cie/get-students-in-section-cie/5B/20cs510/");
    var data = await http.get(url);
    final extractedData = json.decode(data.body) as List<Map<String, dynamic>>;
    print(extractedData);
  }
}
