import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

class CountryModel {
  final int countryID;
  final String countryCode;
  final String countryName;

  CountryModel({this.countryID, this.countryCode, this.countryName});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        countryID: json['id'],
        countryCode: json['countryCode'],
        countryName: json['countryName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryID'] = this.countryID;
    data['countryCode'] = this.countryCode;
    data['countryName'] = this.countryName;
    return data;
  }
}

class CountryListModel {
  List<CountryModel> countryList;

  CountryListModel({this.countryList});

  CountryListModel.fromJson(Map<String, dynamic> json) {

    List<dynamic> jsonList = json['data'];
    countryList = [];

    jsonList.forEach((item) {
      countryList.add(CountryModel.fromJson(item));
    });
  }
}
