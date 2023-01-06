import 'dart:convert';
import 'dart:io';

import 'package:attendance_manager/providers/attendance_status.dart';
import 'package:attendance_manager/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceMarkingScreen extends StatefulWidget {
  static const routeName = '/attendance-marking-screen';
  const AttendanceMarkingScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceMarkingScreen> createState() => _AttendanceMarkingScreenState();
}

class _AttendanceMarkingScreenState extends State<AttendanceMarkingScreen> {
  bool _isLoading=false;
  String courseId='';
  int numberOfClasses=1;
  List<Student> studentsList=[];
  List<AttendanceStatus> attendance=[];

  Future<String> markAttendance(Map<String,dynamic> markAttendance)async{
    String message="";
    SharedPreferences sp=await SharedPreferences.getInstance();
    String? token=sp.getString('token');
    var url=Uri.parse("https://sjce12345.pythonanywhere.com/api/teacher/add-bulk-attendance");
    var response=await http.post(url,body:json.encode(markAttendance),headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Token $token',
    });
      message=json.decode(response.body);
      if(message.contains("Successful")){
        return "Successful";
      }
      else{
        return message;
      }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      var studentsData=ModalRoute.of(context)!.settings.arguments as List<dynamic>;
      studentsList=studentsData[0];
      courseId=studentsData[1];
      numberOfClasses=studentsData[2];
      studentsList.forEach((element) {
        AttendanceStatus newAttendanceStatus=AttendanceStatus(usn: element.usn, status: true);
        attendance.add(newAttendanceStatus);
      });
      setState(() {
        studentsList;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Mark Attendance"),
      ),
      body: studentsList.isEmpty?const Center(child: CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: studentsList.length,
                    itemBuilder: (context, index) => AttendanceTile(attendanceObj:attendance[index],name: studentsList[index].name,))),
            GestureDetector(
              onTap: (){
                setState(() {
                  print("object");
                  _isLoading=true;
                });
                Map<String,dynamic>dataToSend={
                  "course":courseId,
                  "no_of_classes":numberOfClasses,
                  "students":[]
                };
                attendance.forEach((element) {
                  dataToSend['students'].add({
                    "studentUsn":element.usn,
                    "is_present":element.status
                  });
                });
                markAttendance(dataToSend).then((message){
                  if(message=="Successful"){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Attendance marked")));
                    Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                  }
                  setState(() {
                    _isLoading=false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: const BoxDecoration(color: Colors.red),
                child:Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _isLoading?const Center(child: CircularProgressIndicator()):Text("Submit attendance"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final AttendanceStatus attendanceObj;
  final String name;
  const AttendanceTile({super.key, required this.attendanceObj,required this.name});

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: widget.attendanceObj.status,
              onChanged: (value) {
                setState(() {
                  widget.attendanceObj.status = value!;
                });
              }),
          Text(widget.name),
        ],
      ),
    );
  }
}
