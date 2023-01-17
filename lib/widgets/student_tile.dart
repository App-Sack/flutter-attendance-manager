import 'package:attendance_manager/providers/student.dart';
import 'package:attendance_manager/screens/teacher_screens/teacher_calendar_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StudentTile extends StatelessWidget {
  final int rollNo;
  final String courseId;

  StudentTile(
      {super.key,
      required this.courseId,
      required this.rollNo});
  int requiredAttendance = 75;
  @override
  Widget build(BuildContext context) {
    return Consumer<Student>(
      builder: (context,student,child)=>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChangeNotifierProvider.value(value: student,builder: (context,child)=>TeacherCalenderScreen(usn: student.usn,courseId: courseId,studentName: student.name,),)));
            // Navigator.pushNamed(context, TeacherCalenderScreen.routeName,
            //     arguments: [
            //       student.usn,
            //       courseId,
            //       student.present,
            //       student.totalClasses,
            //       student.percentage.toInt(),
            //       student.name
            //     ]);
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: kTTBlueColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kBlueLightColor,
                    child: Text(
                      rollNo.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 5, right: 15),
                  //   decoration: BoxDecoration(
                  //       color: kBlueLightColor,
                  //       borderRadius: BorderRadius.circular(4)),
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  //     child: Text(rollNo.toString()),
                  //   ),
                  // ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          student.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        CircularStepProgressIndicator(
                          width: 50,
                          height: 50,
                          totalSteps: 10,
                          stepSize: 4,
                          currentStep: (student.percentage / 10).toInt(),
                          selectedColor:
                              student.percentage / 10 > requiredAttendance / 10
                                  ? Colors.lightGreen
                                  : Colors.red,
                          unselectedColor: Colors.white,
                          child: Center(
                            child: Text(
                              "${student.percentage.toInt()}%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
