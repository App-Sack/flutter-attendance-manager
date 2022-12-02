import 'package:attendance_manager/screens/teacher_screens/students_list_screen.dart';
import 'package:attendance_manager/widgets/single_class_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SingleClassScreen extends StatelessWidget {
  static const routeName='single-class-screen';
  const SingleClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:[
            SingleClassScreenCard(),
            SingleScreenCard(text: "Attendance",onPressed: (){Navigator.pushNamed(context, StudentsListScreen.routeName);}),
            SingleScreenCard(text: "CIE",onPressed: (){},),
          ],
        ),
      ),
    );
  }
}

class SingleScreenCard extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const SingleScreenCard({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child:Text(text),
        ),
      ),
    );
  }
}
