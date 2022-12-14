import 'package:attendance_manager/providers/cie.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:attendance_manager/widgets/all_marks_table.dart';
import 'package:attendance_manager/widgets/marks_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CieTile extends StatefulWidget {
  String name;
  String usn;
  String e1;
  String e2;
  String e3;
  String e4;
  String e5;
  int avg;
  CieTile(
      {super.key,
        required this.name,
        required this.usn,
        required this.e1,
        required this.e2,
        required this.e3,
        required this.e4,
        required this.e5,
        required this.avg});

  @override
  State<CieTile> createState() => _CieTileState();
}

class _CieTileState extends State<CieTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff023047),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.usn,
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
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Center(
                          child: Column(
                            children: [
                              if (_isExpanded)
                                Column(
                                  children: [
                                    CieTable(
                                      e1: widget.e1,
                                      e2: widget.e2,
                                      e3: widget.e3,
                                      e4: widget.e4,
                                      e5: widget.e5,
                                      avg: widget.avg,
                                    ),
                                    CieInput(
                                      usn: widget.usn,
                                    ),
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
        ],
      ),
    );
  }
}

class CieInput extends StatefulWidget {
  String usn;
  CieInput({super.key, required this.usn});

  @override
  State<CieInput> createState() => _CieInputState();
}

class _CieInputState extends State<CieInput> {
  bool _isLoading = false;
  TextEditingController test1Controller = TextEditingController();
  TextEditingController test2Controller = TextEditingController();
  TextEditingController test3Controller = TextEditingController();
  TextEditingController test4Controller = TextEditingController();
  TextEditingController test5Controller = TextEditingController();
  @override
  void dispose() {
    test1Controller.dispose();
    test2Controller.dispose();
    test3Controller.dispose();
    test4Controller.dispose();
    test5Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)!.settings.arguments as List;

    return Container(
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CieEntryTile(
                        data: "Event 1",
                        controller: test1Controller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CieEntryTile(
                        data: "Event 2",
                        controller: test2Controller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CieEntryTile(
                        data: "Event 3",
                        controller: test3Controller,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CieEntryTile(
                        data: "Event 4",
                        controller: test4Controller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CieEntryTile(
                        data: "Event 5",
                        controller: test5Controller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            print("Loading");
                            _isLoading = true;
                          });
                          Map<String, dynamic> dataToSend = {
                            "usn": widget.usn,
                            "course_id": args[1],
                            "e1": test1Controller.text,
                            "e2": test2Controller.text,
                            "e3": test3Controller.text,
                            "e4": test4Controller.text,
                            "e5": test5Controller.text,
                          };
                          Provider.of<CieProvider>(context, listen: false)
                              .updateCie(dataToSend)
                              .then((message) {
                            if (message == "Successful") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("CIE updated.")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                            }
                          });

                          setState(() {
                            print("Done!");
                            _isLoading = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Update",
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

class CieEntryTile extends StatelessWidget {
  CieEntryTile({required this.data, required this.controller});
  String data;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          data,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          width: 100,
        ),
        InputTextBox(
          txt: data,
          controller: controller,
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        )
      ],
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