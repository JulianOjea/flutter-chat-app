// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String assetPath;
  final String title;

  const Logo({
    Key? key,
    required this.assetPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 170,
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Image(
                  image: AssetImage(assetPath),
                ),
                const SizedBox(height: 20),
                Text(title, style: TextStyle(fontSize: 30))
              ],
            )));
  }
}
