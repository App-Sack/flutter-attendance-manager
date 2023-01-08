import 'package:attendance_manager/screens/teacher_screens/teacher_calendar_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StudentTile extends StatelessWidget {
  final int rollNo;
  final String usn;
  final String name;
  final int attendancePercentage;
  final String courseId;
  final int totalClasses;
  final int present;

  StudentTile(
      {super.key,
      required this.name,
      required this.attendancePercentage,
      required this.usn,
      required this.courseId,
      required this.present,
      required this.totalClasses,
      required this.rollNo
      });
  int requiredAttendance = 75;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, TeacherCalenderScreen.routeName,
            arguments: [
              usn,
              courseId,
              present,
              totalClasses,
              attendancePercentage,
              name
            ]);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: kTTBlueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,right: 15),
                decoration: BoxDecoration(
                  color: kBlueLightColor,
                  borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12,vertical: 8 ),
                  child: Text(
                    rollNo.toString()
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  ),
                    CircularStepProgressIndicator(
                      width: 50,
                      height: 50,
                      totalSteps: 10,
                      stepSize: 4,
                      currentStep: (attendancePercentage / 10).toInt(),
                      selectedColor:
                      attendancePercentage / 10 > requiredAttendance / 10
                          ? Colors.lightGreen
                          : Colors.red,
                      unselectedColor: Colors.white,
                      child: Center(
                        child: Text("$attendancePercentage%"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
