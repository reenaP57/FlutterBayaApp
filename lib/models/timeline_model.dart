import 'dart:convert';

import 'package:flutter/foundation.dart';

class TimeLineModel {
  List<TimelineDataModel> data;
  TimelineMetaModel meta;

  TimeLineModel({this.data, this.meta});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    data = [];

    List<dynamic> jsonList = json['data'];

    jsonList.forEach((item) {
      data.add(TimelineDataModel.fromJson(item));
    });

    meta = TimelineMetaModel.fromJson(json['meta']);
  }
}

class TimelineDataModel {
  int postId;
  int projectId;
  String description;
  String link;
  int mediaType;
  List<dynamic> media;
  String metaTitle;
  String metaDescription;
  String metaImage;
  int viewCount;
  int isViewed;
  int updatedAt;

  TimelineDataModel(
      {this.postId,
      this.projectId,
      this.description,
      this.link,
      this.mediaType,
      this.media,
      this.metaTitle,
      this.metaDescription,
      this.viewCount,
      this.isViewed,
        this.metaImage,
      this.updatedAt});

  factory TimelineDataModel.fromJson(Map<String, dynamic> data) {
    return TimelineDataModel(
      postId: data['postId'],
      projectId: data['projectId'],
      description: data['description'],
      link: data['link'],
      media: data['media'],
      mediaType: data['mediaType'],
      metaDescription: data['metaDescription'],
      metaTitle: data['metaTitle'],
      metaImage: data['metaImage'],
      viewCount: data['viewCount'],
      isViewed: data['isViewed'],
      updatedAt: data['updatedAt'],
    );
  }
}

class TimelineMetaModel {
  int currentPage;
  int lastPage;
  int totalCount;

  TimelineMetaModel({this.currentPage, this.lastPage, this.totalCount});

  factory TimelineMetaModel.fromJson(Map<String, dynamic> meta) {
    return TimelineMetaModel(
        currentPage: meta['current_page'],
        lastPage: meta['last_page'],
        totalCount: meta['total']);
  }
}
