// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BlueBttn extends StatelessWidget {
  final String text;
  final Function? onPressed;

  const BlueBttn({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: const StadiumBorder(),
          backgroundColor: Colors.blue),
      onPressed: () {
        onPressed!();
      },
      child: Container(
        width: double.infinity,
        child: Center(
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 17))),
      ),
    );
  }
}
