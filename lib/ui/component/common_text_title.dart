
import 'package:flutter/material.dart';

class CommonTextTitle extends StatelessWidget {

  final String title;

  const CommonTextTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.normal
      ),
    );
  }

}