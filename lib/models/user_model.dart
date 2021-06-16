import 'dart:async';
import 'dart:convert';

class UserInfoModel {
  int userId;
  String firstName;
  String lastName;
  String email;
  int countryID;
  String mobileNo;
  int userType;
  int pushNotifiy;
  int emailNotifiy;
  int mobileNotifiy;
  int projectCount;
  int favouriteProjectID;
  String favouriteProjectName;
  int favoriteProjectProgress;

  UserInfoModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.countryID,
      this.mobileNo,
      this.userType,
      this.pushNotifiy,
      this.emailNotifiy,
      this.favoriteProjectProgress,
      this.favouriteProjectID,
      this.favouriteProjectName,
      this.mobileNotifiy,
      this.projectCount});

  factory UserInfoModel.fromJson(Map<String, dynamic> data) {
    return UserInfoModel(
        userId: data['userId'] ?? "",
        firstName: data['firstName'] ?? "",
        lastName: data['lastName'] ?? "",
        email: data['email'] ?? "",
        countryID: data['countryId'] ?? 0,
        mobileNo: data['mobileNo'] ?? "",
        userType: data['userType'] ?? 0,
        pushNotifiy: data['pushNotifiy'] ?? 0,
        emailNotifiy: data['emailNotify'] ?? 0,
        mobileNotifiy: data['mobileNotifiy'] ?? 0,
        projectCount: data['projectCount'] ?? 0,
        favouriteProjectID: data['favoriteProjectId'] ?? 0,
        favouriteProjectName: data['favoriteProjectName'] ?? "",
        favoriteProjectProgress: data['favoriteProjectProgress'] ?? 0);
  }

  Map<String, dynamic> defaultUserMap = {
    'firstName': '',
    'lastName': '',
    'email': '',
    'countryId': 0,
    'mobileNo': '',
    'userType': 0,
    'pushNotifiy': 0,
    'emailNotify': 0,
    'projectCount': 0,
    'favoriteProjectId': 0,
    'favoriteProjectName': '',
    'favoriteProjectProgress': 0,
  };
}

class UserMeta {
  int status;
  String token;
  String message;

  UserMeta({this.status, this.token, this.message});

  factory UserMeta.fromJson(Map<String, dynamic> meta) {
    return UserMeta(
        status: meta['status'], token: meta['token'], message: meta['message']);
  }
}

class UserModel {
  dynamic data;
  dynamic meta;

  UserModel({this.data, this.meta});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        data: json['data'] == null
            ? UserInfoModel().defaultUserMap
            : UserInfoModel.fromJson(json['data']),
        meta: UserMeta.fromJson(json['meta']));
  }
}
