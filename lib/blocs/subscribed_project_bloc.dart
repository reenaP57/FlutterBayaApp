import 'dart:async';
import 'package:demo_app/repository/subscribed_project_repository.dart';
import 'package:demo_app/models/project_list_model.dart';
import 'package:demo_app/networking/api_response.dart';

class SubscribedProjectBloc {
  SubscribedProjectRepository subscribedProjectRepository;
  StreamController controller;
  StreamController subscribedController;

  StreamSink<APIResponse<List<ProjectDataModel>>>
      get subscribedProjectListSink => controller.sink;

  Stream<APIResponse<List<ProjectDataModel>>> get subscribedProjectStream =>
      controller.stream;

  StreamSink<APIResponse<Map<String, dynamic>>>
      get subscribedUnsubscribedSink => subscribedController.sink;

  Stream<APIResponse<Map<String, dynamic>>> get subscribedUnsubscribedStream =>
      subscribedController.stream;

  SubscribedProjectBloc() {
    subscribedProjectRepository = SubscribedProjectRepository();
    controller = StreamController<APIResponse<List<ProjectDataModel>>>();
    subscribedController = StreamController<APIResponse<Map<String, dynamic>>>();
  }

  getSubscribedProjectList() async {
    subscribedProjectListSink.add(APIResponse.loading('Fetching...'));
    try {
      List<ProjectDataModel> response =
          await subscribedProjectRepository.getSubscribedProjectList();
      subscribedProjectListSink.add(APIResponse.done(response));
    } catch (error) {
      subscribedProjectListSink.add(APIResponse.error(error.toString()));
    }
  }

  subscribedUnsubscribedProject(Map<String, dynamic> params) async {
    subscribedUnsubscribedSink.add(APIResponse.loading('Processing...'));
    try {
      Map<String, dynamic> response = await subscribedProjectRepository.subscribedProject(params);
      subscribedUnsubscribedSink.add(APIResponse.done(response));
    } catch (error) {
      subscribedUnsubscribedSink.add(APIResponse.error(error.toString()));
    }
  }
}
