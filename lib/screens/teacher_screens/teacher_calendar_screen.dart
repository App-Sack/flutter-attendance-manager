import 'dart:convert';

import 'package:attendance_manager/providers/attendance_data.dart';
import 'package:attendance_manager/widgets/teacher_calender.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class TeacherCalenderScreen extends StatefulWidget {
  static const routeName = '/teacher-calendar-screen';
  const TeacherCalenderScreen({Key? key}) : super(key: key);

  @override
  State<TeacherCalenderScreen> createState() => _TeacherCalenderScreenState();
}

class _TeacherCalenderScreenState extends State<TeacherCalenderScreen> {
  String name = 'Student name';
  List attendanceRecords = [];
  int percentage = 0;
  int present = 0;
  int totalClasses = 0;
  //TODO:Fetch required attendance from the server
  int requiredAttendance = 75;

  // void getAttendanceData(String usn, String courseId) async {
  //   var url = Uri.parse(
  //       "https://sjce12345.pythonanywhere.com/api/student/get-calendar-attendance/$usn/$courseId/");
  //   var data = await http.get(url);
  //   final extractedData = json.decode(data.body) as List<dynamic>;
  //   setState(() {
  //     attendanceRecords = extractedData;
  //   });
  // }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      //TODO:Get arguments as map
      List args = ModalRoute.of(context)!.settings.arguments as List;
      Provider.of<AttendanceDataProvider>(context, listen: false)
          .fetchAndSetAttendanceData(args[0], args[1])
          .then((value) {
        attendanceRecords =
            Provider.of<AttendanceDataProvider>(context, listen: false)
                .getAttendanceData();
        setState(() {
          attendanceRecords;
        });
      });
      present = args[2];
      totalClasses = args[3];
      percentage = args[4];
      name = args[5];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: name == 'Student name'
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff7BABED), Color(0xFF649DED)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 2),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularStepProgressIndicator(
                                  totalSteps: 10,
                                  currentStep: (percentage / 10).toInt(),
                                  stepSize: 5,
                                  selectedColor: (percentage / 10) >
                                          requiredAttendance / 10
                                      ? Colors.lightGreenAccent.shade200
                                      : Colors.redAccent.shade200,
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width:
                                      MediaQuery.of(context).size.height * 0.16,
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  selectedStepSize: 9,
                                  roundedCap: (_, __) => true,
                                  child: Center(
                                    child: Text(
                                      "${(percentage).toString()}%",
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.black38),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Prsent:$present",
                                      //"Present: ${subject.present}",
                                      style: TextStyle(
                                          fontSize: 26, color: Colors.black45),
                                    ),
                                    Text(
                                      "Absent:${totalClasses - present}",
                                      //"Absent: ${subject.absent}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black45),
                                    ),
                                    Text(
                                      "Total:$totalClasses",
                                      //"Total: ${subject.absent + subject.present}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Divider(),
                        // Expanded(
                        //   flex: 1,
                        //   child: AttendanceSuggestion(
                        //       subject.present, subject.absent, requiredAttendance),
                        // ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: TeacherCalendar(
                    attendanceData: attendanceRecords,
                  ),
                ),
              ],
            ),
    );
  }
}
