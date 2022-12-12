import 'package:attendance_manager/screens/teacher_screens/teacher_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, TeacherCalenderScreen.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Student Name"),
              CircularStepProgressIndicator(
                width: 50,
                height: 50,
                totalSteps: 10,
                stepSize: 4,
                currentStep: 7,
                child: Center(
                  child: Text("70%"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
