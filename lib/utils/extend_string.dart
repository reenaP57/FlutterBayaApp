import 'package:flutter/material.dart';


extension ExtendedString on String {

  bool isValidName() => this.contains(RegExp(r'[0–9]'));

  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  bool isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

}
