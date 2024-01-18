// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String question;
  final String outlinedText;

  const Labels({
    Key? key,
    required this.route,
    required this.question,
    required this.outlinedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(question,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              outlinedText,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },
          )
        ],
      ),
    );
  }
}
