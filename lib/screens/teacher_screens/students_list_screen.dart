import 'package:attendance_manager/screens/teacher_screens/attendance_marking_screen.dart';
import 'package:attendance_manager/widgets/student_tile.dart';
import 'package:flutter/material.dart';

class StudentsListScreen extends StatelessWidget {
  static const routeName = '/students-list-screen';
  const StudentsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future DailogBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Number of classes"),
          actions: [
            AlertBoxButton(
              title: "Cancel",
              colour: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            AlertBoxButton(
              title: "Next",
              colour: Colors.green,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AttendanceMarkingScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: DailogBox,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("Mark today\'s attendance")),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 9, itemBuilder: (context, index) => StudentTile()),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertBoxButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color colour;
  AlertBoxButton(
      {super.key, required this.title, this.onPressed, required this.colour});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color?>(colour)),
        onPressed: onPressed,
        child: Text(title));
  }
}
