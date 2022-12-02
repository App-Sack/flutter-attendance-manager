import 'package:attendance_manager/widgets/all_classes_tile.dart';
import 'package:flutter/material.dart';

class AllClassesScreen extends StatelessWidget {
  static const routeName='all-classes-screen';
  const AllClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Classes"),),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context,index)=>ClassTile()),
    );
  }
}
