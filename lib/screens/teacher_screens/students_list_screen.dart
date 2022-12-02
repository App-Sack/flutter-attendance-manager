import 'package:attendance_manager/widgets/student_tile.dart';
import 'package:flutter/material.dart';

class StudentsListScreen extends StatelessWidget {
  static const routeName='/students-list-screen';
  const StudentsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context,index)=>StudentTile()),
      ),
    );
  }
}
