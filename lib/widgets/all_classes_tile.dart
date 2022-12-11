import 'package:attendance_manager/screens/teacher_screens/students_list_screen.dart';
import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  const ClassTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(13),
        child: Container(
          height: 90,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff93B9ED), borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: const RotatedBox(
                  quarterTurns: 3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'CSE:5B', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, letterSpacing: 3),
                      // child: AutoSizeText(
                      //   subject.getTodayStatus(todayDate),
                      //   style: TextStyle(color: Colors.white),
                      //   textAlign: TextAlign.center,
                      //   maxLines: 1,
                      //   minFontSize: 6,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Data structures',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ActionButton(
                          color: Colors.green.shade300,
                          text: 'Attendence',
                          borderRadius: 0.0,
                          onPressed: true,
                        ),
                        ActionButton(
                          color: Colors.red.shade300,
                          text: 'cie',
                          borderRadius: 5.0,
                          onPressed: false,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final double borderRadius;
  final bool onPressed;
  const ActionButton(
      {super.key,
      required this.color,
      required this.text,
      required this.borderRadius,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(borderRadius)),
          ),
          child: InkWell(
            onTap: () {
              if (onPressed) {
                //Attendance Screen
                Navigator.of(context).pushNamed(StudentsListScreen.routeName);
              } else {
                //Cie Screen
              }
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
