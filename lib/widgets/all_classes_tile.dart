import 'package:attendance_manager/screens/teacher_screens/single_class_screen.dart';
import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  const ClassTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, SingleClassScreen.routeName);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.green,
                        child: Text("5th sem"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: Text("B"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                        child: Text("CSE"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey,
                  child: Text("Data Structures"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
