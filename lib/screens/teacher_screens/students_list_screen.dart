import 'package:attendance_manager/providers/student.dart';
import 'package:attendance_manager/screens/teacher_screens/attendance_marking_screen.dart';
import 'package:attendance_manager/utils/colors.dart';
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
  int numberOfClasses = 1;
  String subjectName = "Subject Name";
  String section="";
  List<Student> studentsList = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () {

      // Provider.of<StudentProvider>(context, listen: false)
      //     .fetchAndSetStudents(data[0], courseId)
      //     .then((value) {
      //   studentsList =
      //       Provider.of<StudentProvider>(context, listen: false).studentsList;
      //   setState(() {
      //     subjectName;
      //     studentsList;
      //});
      //});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context)!.settings.arguments as List;
    courseId = data[1];
    subjectName = data[2];
    section=data[0];
    Future DailogBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Number of classes"),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberOfClassButton(
                  icon: Icons.remove,
                  onPressed: () {
                    if (numberOfClasses > 1) {
                      setState(() {
                        --numberOfClasses;
                      });
                    }
                  },
                ),
                Text(numberOfClasses.toString()),
                NumberOfClassButton(
                  icon: Icons.add,
                  onPressed: () {
                    if (numberOfClasses < 3) {
                      setState(() {
                        ++numberOfClasses;
                      });
                    }
                  },
                ),
              ],
            );
          }),
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
                Navigator.pushNamed(context, AttendanceMarkingScreen.routeName,
                    arguments: [studentsList, courseId, numberOfClasses]);
              },
            )
          ],
        ),
      );
    }
    Provider.of<StudentProvider>(context,listen: false).fetchAndSetStudents(section,courseId);

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: kOrangeColor,
      ),
      body: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Consumer<StudentProvider>(
                    builder: (context,provider,child)=>provider.students.isEmpty?Center(child: CircularProgressIndicator(),) :ListView.builder(
                        itemCount: provider.students.length,
                        itemBuilder: (context, index) => ChangeNotifierProvider.value(
                          value: provider.students[index],
                          child: StudentTile(
                                rollNo: index + 1,
                                courseId: courseId,
                              ),
                        )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: kOrangeColor.withOpacity(0.1),
                  child: SafeArea(
                      child: InkWell(
                    onTap:DailogBox,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Text(
                        "Mark Today\'s Attendance",
                        style: TextStyle(
                            color: kOrangeColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  )),
                )
              ],
            ),
    );
  }
}

class NumberOfClassButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  const NumberOfClassButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        child: Icon(icon),
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
