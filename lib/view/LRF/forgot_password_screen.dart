import 'dart:ui';

import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  var countryCodeList = ["+91", "+1", "+92", "69"];
  var selectedCountryCode = '+91';

  var mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      resizeToAvoidBottomInset: false,
      body: forgotPasswordView(),
    );
  }

  Widget forgotPasswordView() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/LRF/bg.jpg'),
      )),
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
        child: Center(
          child: ListView(
            children: [
              Text(
                'Please enter your email/mobile number to recover your password.',
                style: CommonTextField()
                    .commonTextStyle(Colors.black87, 16, FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              mobileNumberField(),
              btnSubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileNumberField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 30),
      child: Container(
        child: Row(
          children: [
            countryDropdownField(),
            Container(
              width: 10,
            ),
            Expanded(
                child: TextField(
              controller: mobileController,
              decoration: CommonTextField().appDecorationStyle(
                  'Enter mobile number or email',
                  'Mobile No/Email',
                  FontWeight.normal,
                  FontWeight.normal,
                  14.0,
                  13.0,
                  Colors.grey,
                  Colors.red,
                  5),
            )),
          ],
        ),
      ),
    );
  }

  Widget countryDropdownField() {
    return SizedBox(
      width: (screenWidth(context) * 70 / 375),
      height: (screenWidth(context) * 45 / 375),
      child: DropdownButtonFormField<String>(
        items: countryCodeList.map((newValue) {
          return DropdownMenuItem(
            value: newValue,
            child: Text(
              newValue,
              style: CommonTextField()
                  .commonTextStyle(Colors.grey, 14, FontWeight.normal),
            ),
          );
        }).toList(),
        onChanged: (changedValue) {
          setState(() {
            selectedCountryCode = changedValue;
          });
        },
        value: selectedCountryCode,
      ),
    );
  }

  Widget btnSubmit() {
    return Padding(
      padding: EdgeInsets.only(
          left: 20.0,
          top: screenWidth(context) * 30 / 375,
          right: 20.0,
          bottom: 0.0),
      child: Container(
          height: screenWidth(context) * 55 / 375,
          width: screenWidth(context) - 40,
          // padding: EdgeInsets.only(top: 30),
          child: ElevatedButton(
              onPressed: () {
                if (mobileController.text.isEmpty) {
                  showAlert();
                }
              },
              child: Text(
                'Submit',
                style: CommonTextField()
                    .commonTextStyle(Colors.white, 20, FontWeight.bold),
              ))),
    );
  }

  void showAlert() {
    AlertDialog alertDialog = AlertDialog(
        title: Text('Baya App'),
        content: Text(
          messageBlankMobileNo,
        ));
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
