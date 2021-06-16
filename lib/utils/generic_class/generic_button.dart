import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/generic_class/generic_text.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/material.dart';

class CommonButton {
  Widget appButton(
      double width,
      double height,
      EdgeInsets padding,
      String title,
      Color color,
      double fontSize,
      FontWeight fontWeight,
      Function func) {
    return Padding(
      padding: padding,
      child: Container(
          height: height,
          width: width,
          child: ElevatedButton(
              onPressed: func,
              child: Text(title,
                  style: CommonTextField()
                      .commonTextStyle(color, fontSize, fontWeight)))),
    );
  }

  Widget gradientThemeButton(String title, Color textColor, double fontSize, FontWeight fontWeight, double width, double height, Color gradient1,
      Color gradient2, Function onTap) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: LinearGradient(
                colors: [AppColor.YellowGradient, AppColor.OrangeGradient],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight)),
        width: 100,
        height: 30,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: CommonText()
                .genericText(title, textColor, fontSize, fontWeight),
          ),
        ));
  }
}
