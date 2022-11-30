import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../widgets/calendar.dart';

class SubjectCalendarScreen extends StatefulWidget {
  static const routeName = '/subject-calendar-screen';

  @override
  State<SubjectCalendarScreen> createState() => _SubjectCalendarScreenState();
}

class _SubjectCalendarScreenState extends State<SubjectCalendarScreen> {
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final subject = Provider.of<Subject>(context);
    // final requiredAttendance = Provider.of<SettingsManager>(context)
    //     .requiredAttendancePercentage
    //     .toDouble();
    // double attendedPercentage = (subject.present + subject.absent == 0)
    //     ? 0
    //     : ((subject.present / (subject.present + subject.absent)) * 10);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("data"),
          backgroundColor: kOrangecolor,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [kOrangecolor, kBluecolor],
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
                              stepSize: 5,
                              selectedColor: Colors.green,
                              // attendedPercentage > requiredAttendance / 10
                              //     ? Colors.lightGreenAccent.shade200
                              //     : Colors.redAccent.shade200,
                              unselectedColor: Colors.grey[200],
                              padding: 0,
                              width: MediaQuery.of(context).size.height * 0.16,
                              height: MediaQuery.of(context).size.height * 0.16,
                              selectedStepSize: 9,
                              roundedCap: (_, __) => true,
                              child: Center(
                                child: Text(
                                  //"${(attendedPercentage * 10).toStringAsFixed(0)}%",
                                  "80",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.black38),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  //"Present: ${subject.present}",
                                  "Present:12",
                                  style: TextStyle(
                                      fontSize: 26, color: Colors.black45),
                                ),
                                Text(
                                  //"Absent: ${subject.absent}",
                                  "Absent:4",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black45),
                                ),
                                Text(
                                  //"Total: ${subject.absent + subject.present}",
                                  "Total:16",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black45),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Calendar("abcd"
                  //subject.id,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
