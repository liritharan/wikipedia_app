import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final  String text;
  final double fontSize;


  TextWidget(this.text,this.fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black38, fontWeight: FontWeight.w400, fontSize: fontSize),
    );
  }
}
