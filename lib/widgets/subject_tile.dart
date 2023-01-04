import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../screens/student_screens/student_calendar_screen.dart';

class SubjectTile extends StatefulWidget {
  final Map<String, dynamic> subjectData;

  const SubjectTile({super.key, required this.subjectData});

  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double attendedPercentage = widget.subjectData['totalClasses'] != 0
        ? (widget.subjectData['totalPresent'] /
                widget.subjectData['totalClasses']) *
            10
        : 0;
    String attendanceStatusText = attendedPercentage == 0
        ? "N/A"
        : attendedPercentage >= 7.5
            ? "On Track"
            : "Off Track";

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, StudentCalendarScreen.routeName,
            arguments: widget.subjectData);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kBlueColor.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff023047).withOpacity(0.87),
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
                              Text(
                                widget.subjectData['courseName'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.subjectData['courseCode'].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          CircularStepProgressIndicator(
                            width: 50,
                            height: 50,
                            totalSteps: 10,
                            stepSize: 4,
                            unselectedColor: Colors.white70,
                            selectedColor: (attendedPercentage) >= 7.5
                                ? Colors.green
                                : Colors.red,
                            currentStep: (attendedPercentage).toInt(),
                            child: Center(
                              child: Text(
                                "${(attendedPercentage * 10).toInt()}%",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Attendance : ${widget.subjectData['totalPresent']}/${widget.subjectData['totalClasses']}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            attendanceStatusText,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = _isExpanded ? false : true;
                });
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kBlueColor.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Center(
                    child: Column(
                  children: [
                    if (_isExpanded)
                      Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Table(
                              border: TableBorder.all(
                                  color: Colors.white60, width: 3),
                              children: [
                                TableRow(children: [
                                  TableData(data: "T1"),
                                  TableData(data: "E1"),
                                  TableData(data: "T2"),
                                  TableData(data: "E2"),
                                  TableData(data: "T3"),
                                  TableData(data: "AVG"),
                                ]),
                                TableRow(children: [
                                  TableData(data: "12"),
                                  TableData(data: "12"),
                                  TableData(data: "12"),
                                  TableData(data: "12"),
                                  TableData(data: "12"),
                                  TableData(data: "60")
                                ])
                              ],
                            ),
                          )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "CIE",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        _isExpanded
                            ? const Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white70,
                              )
                            : const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white70,
                              ),
                      ],
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TableData extends StatelessWidget {
  final String data;

  const TableData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Center(
            child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        data,
        style: TextStyle(color: Colors.white),
      ),
    )));
  }
}
