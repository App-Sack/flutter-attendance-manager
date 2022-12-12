import 'dart:convert';

import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentCalendar extends StatefulWidget {
  final String subId;
  StudentCalendar(this.subId);

  @override
  State<StudentCalendar> createState() => _StudentCalendarState();
}

class _StudentCalendarState extends State<StudentCalendar> {
  List AttendanceRecords = [];

  void getAttendanceData() async {
    SharedPreferences sp=await SharedPreferences.getInstance();
    var url = Uri.parse(
        "https://sjce12345.pythonanywhere.com/api/student/get-calendar-attendance/${sp.getString('usn')}/${widget.subId}/");
    var data = await http.get(url);
    final extractedData = json.decode(data.body) as List<dynamic>;
    setState(() {
      AttendanceRecords = extractedData;
    });
  }

  List _getEvents(BuildContext context, DateTime day) {
    List events = [];
    //final subject = Provider.of<Subjects>(context).findById(widget.subId);
    final String thisDay=DateFormat('dd-MM-yyyy').format(day);

    AttendanceRecords.forEach((record) {
      DateTime recordDate = DateTime.parse(record["date"]);
      if (DateFormat('dd-MM-yyyy').format(recordDate) == thisDay &&
          record["isPresent"]) {
        events.add('p');
      }
      if (DateFormat('dd-MM-yyyy').format(recordDate) == thisDay &&
          !record["isPresent"]) {
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

  @override
  void initState() {
    getAttendanceData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(
        2022,
      ),
      lastDay: DateTime.utc(2124),
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontWeight: FontWeight.w800),
          weekendStyle:
              TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
      weekendDays: const [DateTime.sunday],
      headerStyle:const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        disabledTextStyle: TextStyle(color: Colors.white),
        outsideTextStyle: TextStyle(color: Colors.black45),
        weekendTextStyle: TextStyle(color: Colors.red),
        selectedTextStyle: TextStyle(color: Colors.white),
        //defaultTextStyle: TextStyle(color: Colors.white),
        todayDecoration:
            BoxDecoration(color: kOrangeColor, shape: BoxShape.circle),
        todayTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
            if (e == 'p')
              cor = Colors.green;
            else
              cor = Colors.red;
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
    );
  }
}
