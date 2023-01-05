import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../widgets/all_marks_table.dart';

class CieScreen extends StatefulWidget {
  static const routeName = '/all-cie-screen';

  CieScreen({Key? key}) : super(key: key);

  @override
  State<CieScreen> createState() => _CieScreenState();
}

class _CieScreenState extends State<CieScreen> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CIE"),
        backgroundColor: kBlueColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBlueColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff023047).withOpacity(0.87),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Student Name",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "USN",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = _isExpanded ? false : true;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: kBlueColor.withOpacity(0.7),
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            child: Center(
                                child: Column(
                              children: [
                                if (_isExpanded)
                                  Column(
                                    children: [
                                      CieTable(),
                                      CieInput(),
                                    ],
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "CIE",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    _isExpanded
                                        ? const Icon(
                                            Icons.keyboard_arrow_up,
                                            color: Colors.white70,
                                          )
                                        : const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white70,
                                          ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class CieInput extends StatelessWidget {
  const CieInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputTextBox(txt: "Test 1"),
                      SizedBox(
                        width: 35,
                      ),
                      InputTextBox(txt: "Test 2"),
                      SizedBox(
                        width: 35,
                      ),
                      InputTextBox(txt: "Test 3"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputTextBox(txt: "Event 1"),
                      SizedBox(
                        width: 35,
                      ),
                      InputTextBox(txt: "Event 2"),
                      SizedBox(
                        width: 35,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 80,
                          child: Center(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.green),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}

class InputTextBox extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final String txt;
  InputTextBox({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      child: FormBuilderTextField(
        key: _formKey,
        name: txt,
        decoration: InputDecoration(
          labelText: txt,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 3.0),
          ),
        ),
      ),
    );
  }
}

class TableData extends StatelessWidget {
  final String data;

  const TableData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Center(
            child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        data,
        style: TextStyle(color: Colors.white),
      ),
    )));
  }
}
