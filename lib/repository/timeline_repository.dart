import 'package:demo_app/models/timeline_model.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/networking/api_request_helper.dart';

class TimelineRepository {

  APIRequestHelper helper = APIRequestHelper();

  Future<TimeLineModel> getTimelineList(Map<String, dynamic> params) async {
    var response = await helper.push(APITag.timelinelist, params);
    return TimeLineModel.fromJson(response);
  }
}