import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/material.dart';

class CommonText {
  Widget genericText(String title, Color textColor, double fontSize,
      FontWeight fontWeight, {EdgeInsets padding = EdgeInsets.zero}) {
    return Padding(
      padding: padding,
      child: Text(
        title,
        style:
            CommonTextField().commonTextStyle(textColor, fontSize, fontWeight),
      ),
    );
  }
}
