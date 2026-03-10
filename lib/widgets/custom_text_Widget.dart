import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
 String text;
 TextStyle textStyle;
CustomTextWidget({required this.text,required this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
