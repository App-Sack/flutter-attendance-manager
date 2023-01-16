import 'package:attendance_manager/providers/attendance_data.dart';
import 'package:attendance_manager/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TeacherCalendar extends StatefulWidget {
  final List<dynamic> attendanceData;
  final String usn;
  final String courseId;
  const TeacherCalendar({super.key, required this.attendanceData,required this.courseId,required this.usn});

  @override
  State<TeacherCalendar> createState() => _TeacherCalendarState();
}

class _TeacherCalendarState extends State<TeacherCalendar> {
  List _getEvents(BuildContext context, DateTime day) {
    List events = [];
    //final subject = Provider.of<Subjects>(context).findById(widget.subId);
    final String thisDay = DateFormat('dd-MM-yyyy').format(day);
    widget.attendanceData.forEach((record) {
      DateTime recordDate = DateTime.parse(record.date);
      if (DateFormat('dd-MM-yyyy').format(recordDate) == thisDay &&
          record.isPresent) {
        events.add('p');
      }
      if (DateFormat('dd-MM-yyyy').format(recordDate) == thisDay &&
          !record.isPresent) {
        events.add('a');
      }
    });

    // subject.presentEvents.where((e) => e == thisDay).forEach((e) {
    //   events.add('p');
    // });
    // subject.absentEvents.where((e) => e == thisDay).forEach((e) {
    //   events.add('a');
    // });
    // subject.noClassEvents.where((e) => e == thisDay).forEach((e) {
    //   events.add('n');
    // });

    return events;
  }

  void _addEventOnTap(DateTime d) {
    showDialog(
        context: context,
        builder: (_) {
          //final subject = Provider.of<Subjects>(context).findById(widget.subId);
          final date = DateFormat('yyyy-MM-dd').format(d);
          return AlertDialog(
            title: Text(DateFormat('EE, MMM d').format(d)),
            content: Text("Set/Reset Attendance for subject name"),
            //Text("Set/Reset Attendance for ${subject.title} ?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<AttendanceDataProvider>(context,listen: false).markAttendanceForSingleDay(date, widget.usn, widget.courseId, true);
                          Provider.of<StudentProvider>(context,listen: false).markPresent(widget.usn);
                          //subject.addPresentEvent(date);

                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Present",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green, padding: EdgeInsets.all(8)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<AttendanceDataProvider>(context,listen: false).markAttendanceForSingleDay(date, widget.usn, widget.courseId, false);
                        Provider.of<StudentProvider>(context,listen: false).markAbsent(widget.usn);
                        //subject.addAbsentEvent(date);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Absent",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red, padding: EdgeInsets.all(8)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<AttendanceDataProvider>(context,listen: false).clearAttendance(date,widget.usn,widget.courseId);
                      }
                          //subject.clearAllEventsOnDay(date);

                          );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black, padding: EdgeInsets.all(8)),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(
        2022,
      ),
      lastDay: DateTime.now(),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontWeight: FontWeight.w800),
          weekendStyle:
              TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      weekendDays: [DateTime.sunday],
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        outsideTextStyle: TextStyle(color: Colors.black45),
        weekendTextStyle: TextStyle(color: Colors.red),
        selectedTextStyle: TextStyle(color: Colors.white),
        //defaultTextStyle: TextStyle(color: Colors.white),
        todayDecoration: BoxDecoration(
            color: Colors.lightBlue.shade50, shape: BoxShape.circle),
        todayTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      eventLoader: (day) => _getEvents(context, day),
      calendarBuilders:
          CalendarBuilders(markerBuilder: (context, date, events) {
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: events.map((event) {
            String e = event.toString();
            Color cor;
            if (e == "p")
              cor = Colors.lightGreenAccent;
            else if (e == 'a')
              cor = Colors.red;
            else
              cor = Colors.yellow;
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: cor),
                width: 7.0,
                height: 7.0,
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
              ),
            );
          }).toList(),
        );
      }),
      onDaySelected: (a, b) {
        _addEventOnTap(a);
      },
    );
  }
}
