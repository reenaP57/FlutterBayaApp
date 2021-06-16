import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}


const messageBlankPassword = 'Please enter password.';
const messageBlankConfirmPassword = 'Please enter confirm password.';
const messageDoesNotMatchPassword = 'Password and confirm password does not match.';
const messageInValidEmail = 'Please enter valid email.';
const messageBlankEmail = 'Please enter email address.';
const messageBlankFName = 'Please enter first name.';
const messageBlankLName = 'Please enter last name.';
const messageValidFName = 'Please enter valid first name.';
const messageValidLName = 'Please enter valid last name.';
const messageBlankMobileNo = 'Please enter mobile number.';
const messageValidMobileNo = 'Please enter valid mobile number.';

Future<String> getToken() async {
  final sharedPreference = await SharedPreferences.getInstance();
  return sharedPreference.getString('UserKey');
}