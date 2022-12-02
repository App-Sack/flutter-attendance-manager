import 'package:flutter/material.dart';

class SingleClassScreenCard extends StatelessWidget {
  const SingleClassScreenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
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
            Row(
              children: [
                Container(
                  child: Text("Total Strength"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
