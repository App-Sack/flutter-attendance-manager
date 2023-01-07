import 'package:flutter/material.dart';

class CieTable extends StatelessWidget {
  String e1;
  String e2;
  String e3;
  String e4;
  String e5;
  int avg;
  CieTable(
      {required this.e1,
      required this.e2,
      required this.e3,
      required this.e4,
      required this.e5,
      required this.avg});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            border: TableBorder.all(color: Colors.white60, width: 3),
            children: [
              TableRow(children: [
                TableData(data: "T1"),
                TableData(data: "E1"),
                TableData(data: "T2"),
                TableData(data: "E2"),
                TableData(data: "T3"),
                TableData(data: "AVG"),
              ]),
              TableRow(children: [
                TableData(data: e1),
                TableData(data: e2),
                TableData(data: e3),
                TableData(data: e4),
                TableData(data: e5),
                TableData(data: avg.toString()),
              ])
            ],
          ),
        ));
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
