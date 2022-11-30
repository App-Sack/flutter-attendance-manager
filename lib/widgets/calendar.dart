import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class Calendar extends StatefulWidget {
  final String subId;
  Calendar(this.subId);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List _getEvents(BuildContext context, DateTime day) {
    List events = [];
    //final subject = Provider.of<Subjects>(context).findById(widget.subId);
    final String thisDay = DateFormat('dd-MM-yyyy').format(day);

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
    );
  }
}