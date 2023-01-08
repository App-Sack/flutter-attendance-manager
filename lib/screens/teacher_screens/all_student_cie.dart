import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:attendance_manager/providers/cie.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/all_marks_table.dart';
import '../../widgets/marks_input_field.dart';

class CieScreen extends StatefulWidget {
  static const routeName = '/all-cie-screen';

  const CieScreen({Key? key}) : super(key: key);

  @override
  State<CieScreen> createState() => _CieScreenState();
}

class _CieScreenState extends State<CieScreen> {
  bool _isExpanded = false;
  List<CIE> cieList = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    cieList = [];
    Future.delayed(Duration.zero, () {
      List args = ModalRoute.of(context)!.settings.arguments as List;
      Provider.of<CieProvider>(context, listen: false)
          .fetchAndSetCieData(args[0], args[1])
          .then((value) {
        cieList = Provider.of<CieProvider>(context, listen: false).CieData;
        setState(() {
          cieList;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numsub = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("CIE"),
        backgroundColor: kBlueColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: cieList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: cieList.length,
                  itemBuilder: ((context, index) {
                    return CieTile(
                        name: cieList[index].student_name,
                        usn: cieList[index].usn,
                        e1: cieList[index].e1 == null
                            ? "-"
                            : cieList[index].e1.toString(),
                        e2: cieList[index].e2 == null
                            ? "-"
                            : cieList[index].e2.toString(),
                        e3: cieList[index].e3 == null
                            ? "-"
                            : cieList[index].e3.toString(),
                        e4: cieList[index].e4 == null
                            ? "-"
                            : cieList[index].e4.toString(),
                        e5: cieList[index].e5 == null
                            ? "-"
                            : cieList[index].e5.toString(),
                        avg: (((cieList[index].e1 ?? 0) +
                                (cieList[index].e2 ?? 0) +
                                (cieList[index].e3 ?? 0) +
                                (cieList[index].e4 ?? 0) +
                                (cieList[index].e5 ?? 0)) ~/
                            2));
                  }))),
    );
  }
}

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
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
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
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)!.settings.arguments as List;
    TextEditingController test1Controller = TextEditingController();
    TextEditingController test2Controller = TextEditingController();
    TextEditingController test3Controller = TextEditingController();
    TextEditingController event1Controller = TextEditingController();
    TextEditingController event2Controller = TextEditingController();
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
                        controller: event1Controller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CieEntryTile(
                        data: "Event 5",
                        controller: event2Controller,
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
                            "e2": event1Controller.text,
                            "e3": test2Controller.text,
                            "e4": event2Controller.text,
                            "e5": test3Controller.text,
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
