import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InputTextBox extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final String txt;
  TextEditingController controller;
  InputTextBox({super.key, required this.txt,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      child: FormBuilderTextField(
        key: _formKey,
        controller: controller,
        name: txt,
        decoration: InputDecoration(
          labelText: txt,
          labelStyle: TextStyle(color: Colors.white),
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
