import 'dart:convert';

import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final String subId;
  Calendar(this.subId);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List AttendanceRecords = [];

  void getAttendanceData() async {
    var url = Uri.parse(
        "https://shivam13.pythonanywhere.com/api/student/get-calendar-attendance/01jst20cs036/${widget.subId}/");
    var data = await http.get(url);
    print(data.body);
    final extractedData = json.decode(data.body) as List<dynamic>;
    print(extractedData);
    print(extractedData[0]['date'].toString());
    setState(() {
      AttendanceRecords = extractedData;
    });
  }

  List _getEvents(BuildContext context, DateTime day) {
    List events = [];
    //final subject = Provider.of<Subjects>(context).findById(widget.subId);
    final String thisDay = DateFormat('dd-MM-yyyy').format(day);

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
        disabledTextStyle: TextStyle(color: Colors.white),
        outsideTextStyle: TextStyle(color: Colors.black45),
        weekendTextStyle: TextStyle(color: Colors.red),
        selectedTextStyle: TextStyle(color: Colors.white),
        //defaultTextStyle: TextStyle(color: Colors.white),
        todayDecoration:
            BoxDecoration(color: kOrangeColor, shape: BoxShape.circle),
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
