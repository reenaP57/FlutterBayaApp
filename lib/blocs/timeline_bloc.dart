import 'dart:async';

import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/timeline_repository.dart';
import 'package:demo_app/models/timeline_model.dart';

class TimelineBloc {
  TimelineRepository timelineRepository;
  StreamController timelineController;

  StreamSink<APIResponse<TimeLineModel>> get timelineListSink =>
      timelineController.sink;

  Stream<APIResponse<TimeLineModel>> get timelineStream =>
      timelineController.stream;

  TimelineBloc() {
    timelineRepository = TimelineRepository();
    timelineController = StreamController<APIResponse<TimeLineModel>>();
  }

  getTimelineList(Map<String, dynamic> params) async {
    timelineListSink.add(APIResponse.loading('Fetching...'));
    try {
      TimeLineModel response = await timelineRepository.getTimelineList(params);
      timelineListSink.add(APIResponse.done(response));
    } catch (error) {
      timelineListSink.add(APIResponse.error(error.toString()));
    }
  }
}
