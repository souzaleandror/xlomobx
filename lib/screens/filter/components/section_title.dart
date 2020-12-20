import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.purple, fontSize: 13, fontWeight: FontWeight.w400),
      ),
    );
  }
}
