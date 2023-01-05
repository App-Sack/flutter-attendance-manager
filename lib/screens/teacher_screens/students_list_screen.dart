import 'package:attendance_manager/providers/student.dart';
import 'package:attendance_manager/screens/teacher_screens/attendance_marking_screen.dart';
import 'package:attendance_manager/widgets/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsListScreen extends StatefulWidget {
  static const routeName = '/students-list-screen';
  const StudentsListScreen({Key? key}) : super(key: key);

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  late String courseId;
  List<Student> studentsList=[];
  @override
  void initState() {

    Future.delayed(Duration.zero,(){
      List data=ModalRoute.of(context)!.settings.arguments as List;
      courseId=data[1];
      Provider.of<StudentProvider>(context,listen: false).fetchAndSetStudents(data[0],courseId).then((value){
        studentsList=Provider.of<StudentProvider>(context,listen: false).studentsList;
        setState(() {
          studentsList;
        });
      });
    });
    super.initState();
  }
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
      body: studentsList.isEmpty?Center(child: CircularProgressIndicator()):Padding(
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
                  itemCount: studentsList.length, itemBuilder: (context, index) => StudentTile(name: studentsList[index].name,present: studentsList[index].present,totalClasses: studentsList[index].totalClasses,attendancePercentage: studentsList[index].percentage.toInt(),usn: studentsList[index].usn,courseId: courseId,)),
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
