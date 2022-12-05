import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../screens/student_screens/subject_calendar_screen.dart';

class SubjectTile extends StatelessWidget {
  final Map<String,dynamic> subjectData;

  const SubjectTile({super.key, required this.subjectData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SubjectCalendarScreen.routeName,
            arguments: subjectData);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff023047).withOpacity(0.87),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subjectData['courseName'],style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(subjectData['courseCode'].toString(),style: TextStyle(color: Colors.white),),
                      ],
                    ),
                    CircularStepProgressIndicator(
                      width: 50,
                      height: 50,
                      totalSteps: 10,
                      stepSize: 4,
                      unselectedColor: Colors.white70,
                      selectedColor: ((subjectData['totalPresent'] /
                          subjectData['totalClasses']) *
                          10)>=7.5?Colors.green:Colors.red,
                      currentStep: ((subjectData['totalPresent'] /
                          subjectData['totalClasses']) *
                          10)
                          .toInt(),
                      child: Center(child: Text("${((subjectData['totalPresent'] /
                          subjectData['totalClasses']) *
                          100)
                          .toInt()}%",style: TextStyle(fontSize: 12,color: Colors.white),),),
                    ),
                  ],
                ),
                Divider(color: Colors.white,thickness: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Attendance : ${subjectData['totalPresent']}/${subjectData['totalClasses']}",style: TextStyle(color: Colors.white70),),
                    ((subjectData['totalPresent'] /
                        subjectData['totalClasses']) *
                        10)>=7.5?Text("On track",style: TextStyle(color: Colors.white70),):Text("Off track",style: TextStyle(color: Colors.white70),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
