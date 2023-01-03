import 'package:attendance_manager/resources/auth_methods.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/widgets/all_classes_tile.dart';
import 'package:flutter/material.dart';

class AllClassesScreen extends StatelessWidget {
  static const routeName = 'all-classes-screen';
  const AllClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Classes"),
        actions: [
          IconButton(
              onPressed: () {
                AuthMethods().LogOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
          itemCount: 6, itemBuilder: (context, index) => ClassTile()),
    );
  }
}
