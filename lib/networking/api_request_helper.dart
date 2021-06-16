import 'dart:io';
import 'package:demo_app/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APITag {
  static const countryList = 'country';
  static const login = 'login';
  static const signUp = 'signup';
  static const projectList = 'projectlist';
  static const subscribedProject = 'subscribed-project';
  static const timelinelist = 'timelinelist';
  static const projectSubscribe = 'project-subscribe';
}

class APIRequestHelper {
  final String baseURL = 'https://api.thebayacompany.com/v1/';

  Map<String, String> header = {
    'Accept': 'application/json',
    'Accept-Language': 'en'
  };

  Future<dynamic> get(String apiTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('UserToken');

    var headerAuth = header;
    headerAuth['Authorization'] = 'Bearer $token';

    print('============ Token: $token');
    var responseJson;
    try {
      var response;
      if (token != null) {
        response =
            await http.get(Uri.parse(baseURL + apiTag), headers: headerAuth);
      } else {
        response = await http.get(Uri.parse(baseURL + apiTag));
      }
      // final response = await http.get(Uri.parse(baseURL + apiTag), headers: (getToken() != null) ? headerAuth : {}));
      responseJson = getResponse(response);
    } on SocketException {
      throw Exception('Something is wrong');
    }

    return responseJson;
  }

  Future<dynamic> push(String apiTag, Map<String, dynamic> parameters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('UserToken');

    var headerAuth = header;
    headerAuth['Authorization'] = 'Bearer $token';

    var responseJson;
    try {
      final response = await http.post(Uri.parse(baseURL + apiTag),
          body: parameters, headers: (token != null) ? headerAuth : header);
      responseJson = jsonDecode(response.body.toString());
    } on SocketException {
      throw Exception('Something is wrong');
    }

    return responseJson;
  }

  Future<dynamic> pushMultiFormData(
      String apiTag, Map<String, dynamic> parameters) async {
    Map<String, String> stringQueryParameters =
        parameters.map((key, value) => MapEntry(key, value?.toString()));

    var headerAuth = header;
    headerAuth['Authorization'] = 'Bearer $getToken()';

    var responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL + apiTag))
        ..fields.addAll(stringQueryParameters)
        ..headers.addAll((getToken() != null) ? headerAuth : header);
      var response = await request.send();
      final responseToString = await response.stream.bytesToString();
      responseJson = jsonDecode(responseToString);
    } on SocketException {
      throw Exception('Something is wrong');
    }

    return responseJson;
  }

  dynamic getResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body.toString());
      default:
        return Exception(response.body.toString());
    }
  }
}
