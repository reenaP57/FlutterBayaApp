import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProjectListModel {
  List<ProjectDataModel> data;
  ProjectMetaModel meta;

  ProjectListModel({this.data, this.meta});

  ProjectListModel.fromJson(Map<String, dynamic> json) {
    data = [];

    List<dynamic> jsonList = json['data'];
    jsonList.forEach((item) {
      data.add(ProjectDataModel.fromJson(item));
    });

    meta = ProjectMetaModel.fromJson(json['meta']);
  }
}

class ProjectDataModel {
  int projectId;
  String projectName;
  String projectImage;
  String address;
  String shortLocation;
  String description;
  int isSubscribe;
  int isFavorite;
  int isSoldOut;
  String reraNumber;
  int statusId;
  String mobileNo;

  ProjectDataModel(
      {this.projectId,
      this.projectImage,
      this.projectName,
      this.address,
      this.shortLocation,
      this.description,
      this.isSubscribe,
      this.isFavorite,
      this.isSoldOut,
      this.statusId,
      this.reraNumber,
      this.mobileNo});

  factory ProjectDataModel.fromJson(Map<String, dynamic> data) {
    return ProjectDataModel(
        projectId: data['projectId'],
        projectName: data['projectName'],
        projectImage: data['projectImage'],
        address: data['address'],
        shortLocation: data['shortLocation'],
        description: data['description'],
        isSubscribe: data['isSubscribe'],
        isFavorite: data['isFavorite'],
        isSoldOut: data['isSoldOut'],
        reraNumber: (data['reraNumber'] == null) ? '' : data['reraNumber'],
        statusId: (data['statusId'] == null) ? 0 : data['statusId'],
        mobileNo: ((data['contactDetail'] == null) || (data['contactDetail'] as List<dynamic>).length == 0) ? '' : (data['contactDetail'] as List<dynamic>).first['mobileNo']);
  }
}

class ProjectMetaModel {
  int current_page;
  int last_page;
  int total;
  int status;

  ProjectMetaModel(
      {this.current_page, this.last_page, this.total, this.status});

  factory ProjectMetaModel.fromJson(Map<String, dynamic> meta) {
    return ProjectMetaModel(
        current_page: meta['current_page'],
        last_page: meta['last_page'],
        total: meta['total'],
        status: meta['status']);
  }
}
