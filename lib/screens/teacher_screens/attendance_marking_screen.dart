import 'package:attendance_manager/providers/student.dart';
import 'package:flutter/material.dart';

class AttendanceMarkingScreen extends StatefulWidget {
  static const routeName = '/attendance-marking-screen';
  const AttendanceMarkingScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceMarkingScreen> createState() => _AttendanceMarkingScreenState();
}

class _AttendanceMarkingScreenState extends State<AttendanceMarkingScreen> {
  List<Student> studentsList=[];
  @override
  void initState() {

    Future.delayed(Duration.zero,(){
      studentsList=ModalRoute.of(context)!.settings.arguments as List<Student>;
      setState(() {
        studentsList;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Mark Attendance"),
      ),
      body: studentsList.isEmpty?const Center(child: CircularProgressIndicator(),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: studentsList.length,
                    itemBuilder: (context, index) => AttendanceTile(name: studentsList[index].name,))),
            Container(
              margin: const EdgeInsets.only(top: 2),
              decoration: const BoxDecoration(color: Colors.red),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Submit attendance"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final String name;
  bool status = true;

  AttendanceTile({super.key, required this.name});
  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: widget.status,
              onChanged: (value) {
                setState(() {
                  widget.status = value!;
                });
              }),
          Text(widget.name),
        ],
      ),
    );
  }
}
