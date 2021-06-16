import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/utils/app_colors.dart';

class LoadingView extends StatelessWidget {
  final String loadingMessage;

  const LoadingView({this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return loadingViewWithTitle();
  }

  Widget loadingViewWithTitle() {
    return Center(
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 150,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      loadingMessage,
                      style: CommonTextField().commonTextStyle(
                          AppColor.AppTheme, 14.0, FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                ],
              ),
            )));
  }

  Widget loader() {
    return Center(
      child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: Colors.green,
          )),
    );
  }

  showLoaderWithTitle(bool isShowLoader, BuildContext context,
      {String message = 'Processing...'}) {
    if (isShowLoader) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => LoadingView(loadingMessage: message));
    } else {
      Navigator.of(context, rootNavigator: true).pop("");
    }
  }

  showLoader(bool isShowLoader, BuildContext context) {
    if (isShowLoader) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => loader());
    } else {
      Navigator.of(context, rootNavigator: true).pop("");
    }
  }
}
