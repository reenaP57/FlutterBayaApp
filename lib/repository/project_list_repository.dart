import 'package:demo_app/networking/api_request_helper.dart';
import 'package:demo_app/models/project_list_model.dart';

class ProjectListRepository {
  APIRequestHelper helper = APIRequestHelper();

  Future<ProjectListModel> getProjectList(
      Map<String, dynamic> parameter) async {
    var response = await helper.push(APITag.projectList, parameter);
    return ProjectListModel.fromJson(response);
  }
}
