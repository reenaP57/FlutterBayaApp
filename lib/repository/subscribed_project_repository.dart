import 'package:demo_app/networking/api_request_helper.dart';
import 'package:demo_app/models/project_list_model.dart';
import 'dart:core';
import 'package:http/http.dart';

import 'package:http/http.dart';

class SubscribedProjectRepository {
  APIRequestHelper helper = APIRequestHelper();

  Future<List<ProjectDataModel>> getSubscribedProjectList() async {
    var response = await helper.push(APITag.subscribedProject, {'': ''});

    List<dynamic> itemList = response['data'];
    List<ProjectDataModel> projectlist = [];
    itemList.forEach((item) {
      projectlist.add(ProjectDataModel.fromJson(item));
    });

    return projectlist;
  }

  Future<dynamic> subscribedProject(Map<String, dynamic> params) async {

    var response = await helper.push(APITag.projectSubscribe, params);
    return response;
  }
}
