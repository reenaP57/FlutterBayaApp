import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/material.dart';

class AlertView {
  showAlertView(BuildContext context, String message, Function onPressed,
      {String title = "", String action = "Okay"}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: onPressed,
            child: Text(
              action,
              style: CommonTextField()
                  .commonTextStyle(AppColor.AppTheme, 16, FontWeight.w400),
            ))
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  showAlertViewWithTwoButton(
      BuildContext context, String message, String action1, String action2, Function onPressedAction1, Function onPressedAction2,
      {String title = ""}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: onPressedAction1,
            child: Text(
              action1,
              style: CommonTextField()
                  .commonTextStyle(AppColor.AppTheme, 16, FontWeight.w400),
            )),
        TextButton(
            onPressed: onPressedAction2,
            child: Text(
              action2,
              style: CommonTextField()
                  .commonTextStyle(AppColor.AppTheme, 16, FontWeight.w400),
            ))
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
