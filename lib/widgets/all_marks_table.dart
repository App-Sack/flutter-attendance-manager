import 'package:flutter/material.dart';

class CieTable extends StatelessWidget {
  const CieTable({
    Key? key,
  }) : super(key: key);

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
                TableData(data: "12"),
                TableData(data: "12"),
                TableData(data: "12"),
                TableData(data: "12"),
                TableData(data: "12"),
                TableData(data: "60")
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
