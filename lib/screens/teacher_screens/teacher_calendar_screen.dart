import 'package:attendance_manager/widgets/teacher_calender.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TeacherCalenderScreen extends StatelessWidget {
  static const routeName='/teacher-calendar-screen';
  const TeacherCalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("sample"),),
      body: Column(
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
                            currentStep: 7,
                            //attendedPercentage.toInt(),
                            stepSize: 5,
                            selectedColor:Colors.lightGreenAccent.shade200,
                            // attendedPercentage > requiredAttendance / 10
                            //     ? Colors.lightGreenAccent.shade200
                            //     : Colors.redAccent.shade200,
                            unselectedColor: Colors.grey[200],
                            padding: 0,
                            width: MediaQuery.of(context).size.height*0.16,
                            height: MediaQuery.of(context).size.height*0.16,
                            selectedStepSize: 9,
                            roundedCap: (_, __) => true,
                            child: const Center(
                              child: Text(
                                "70%",
                                //"${(attendedPercentage * 10).toStringAsFixed(0)}%",
                                style: TextStyle(
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
                            children: const [
                              Text(
                                "Prsent:25",
                                //"Present: ${subject.present}",
                                style: TextStyle(
                                    fontSize: 26, color: Colors.black45),
                              ),
                              Text(
                                "Absent:3",
                                //"Absent: ${subject.absent}",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black45),
                              ),
                              Text(
                                "Total:28",
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TeacherCalendar(),
          ),
        ],
      ),
    );
  }
}
