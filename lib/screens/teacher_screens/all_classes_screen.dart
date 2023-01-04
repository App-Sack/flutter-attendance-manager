import 'package:attendance_manager/providers/teacher.dart';
import 'package:attendance_manager/resources/auth_methods.dart';
import 'package:attendance_manager/screens/student_screens/login_screen.dart';
import 'package:attendance_manager/widgets/all_classes_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllClassesScreen extends StatefulWidget {
  static const routeName = 'all-classes-screen';
  const AllClassesScreen({Key? key}) : super(key: key);

  @override
  State<AllClassesScreen> createState() => _AllClassesScreenState();
}

class _AllClassesScreenState extends State<AllClassesScreen> {
  List<dynamic> classes=[];
  @override
  void initState() {
    classes = Provider.of<TeacherProvider>(context).getClasses();
    super.initState();
  }
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
              icon: const Icon(Icons.logout))
        ],
      ),
      body: classes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) => ClassTile(
                subjectName: classes[index]['course']!,
                section: classes[index]['section']!,
              ),
            ),
    );
  }
}
