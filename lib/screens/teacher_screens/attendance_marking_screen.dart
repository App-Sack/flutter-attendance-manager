import 'package:flutter/material.dart';

class AttendanceMarkingScreen extends StatelessWidget {
  static const routeName = '/attendance-marking-screen';
  const AttendanceMarkingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => AttendanceTile())),
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
  AttendanceTile({
    Key? key,
  }) : super(key: key);
  bool status = true;
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
          Text("Student name"),
        ],
      ),
    );
  }
}
