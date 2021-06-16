import 'dart:async';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/project_list_repository.dart';
import 'package:demo_app/models/project_list_model.dart';

class ProjectListBloc {
  ProjectListRepository projectListRepository;
  StreamController projectController;

  StreamSink<APIResponse<ProjectListModel>> get projectListSink =>
      projectController.sink;

  Stream<APIResponse<ProjectListModel>> get projectStream =>
      projectController.stream;

  ProjectListBloc() {
    projectListRepository = ProjectListRepository();
    projectController = StreamController<APIResponse<ProjectListModel>>();
  }

  getProjectList(Map<String, dynamic> param) async {
    projectListSink.add(APIResponse.loading('Loading...'));
    try {
      ProjectListModel response = await projectListRepository.getProjectList(
          param);
      projectListSink.add(APIResponse.done(response));
    } catch (error) {
      projectListSink.add(APIResponse.error(error.toString()));
    }
  }

  dispose(){
    projectController.close();
  }
}
