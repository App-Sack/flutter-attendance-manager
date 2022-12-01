import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../screens/subject_calendar_screen.dart';

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
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subjectData['courseName']),
                    Text(subjectData['courseCode'].toString()),
                  ],
                ),
                CircularStepProgressIndicator(
                  width: 50,
                  height: 50,
                  totalSteps: 10,
                  stepSize: 4,
                  currentStep: ((subjectData['totalPresent'] /
                      subjectData['totalClasses']) *
                      10)
                      .toInt(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
