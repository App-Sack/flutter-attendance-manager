import 'package:flutter/material.dart';
class LoginScreenButton extends StatelessWidget {
  final String textLabel;
  final Function()? onPressed;

  LoginScreenButton({super.key, required this.textLabel, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12),
          child: Center(child: Text(textLabel)),
        ),
      ),
    );
  }
}