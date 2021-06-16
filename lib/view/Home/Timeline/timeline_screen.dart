import 'package:demo_app/blocs/subscribed_project_bloc.dart';
import 'package:demo_app/blocs/timeline_bloc.dart';
import 'package:demo_app/models/project_list_model.dart';
import 'package:demo_app/models/timeline_model.dart';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/utils/alertview.dart';
import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/loading_view.dart';
import 'package:demo_app/view/Home/Timeline/timeline_image_view.dart';
import 'package:demo_app/view/Home/Timeline/timeline_text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'timeline_schedule_view.dart';
import 'dart:async';

class TimeLineScreen extends StatefulWidget {
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  SubscribedProjectBloc subscribedProjectBloc;
  TimelineBloc timelineBloc;

  List<TimelineDataModel> timelineList;

  ScrollController scrollController = ScrollController();

  String projectID;
  int currentPage = 1;
  int lastPage = 0;

  @override
  void initState() {
    super.initState();

    timelineList = [];
    subscribedProjectBloc = SubscribedProjectBloc();
    timelineBloc = TimelineBloc();

    subscribedProjectBloc.getSubscribedProjectList();

    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeLine'),
      ),
      body: subscribedProjectStreamBuilder(),
    );
  }

  Widget subscribedProjectStreamBuilder() {
    return StreamBuilder<APIResponse<List<ProjectDataModel>>>(
        stream: subscribedProjectBloc.subscribedProjectStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.Loading:
                return LoadingView().loader();

              case Status.Done:
                {
                  projectID = snapshot.data.data.first.projectId.toString();
                  getTimelineList();
                  return timelineView(snapshot.data.data);
                }

              case Status.Error:
                AlertView().showAlertView(
                    context, snapshot.data.message.toString(), () {});
            }
          }
        });
  }

  Widget timelineView(List<ProjectDataModel> projectList) {
    return RefreshIndicator(
        backgroundColor: AppColor.AppTheme,
        color: Colors.white,
        child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 155,
                      child:
                          TimelineScheduleView(projectList, (String projectId) {
                        projectID = projectId;
                        refreshTimeLineList();
                      })),
                  timelineListStreamBuilder()
                ],
              ),
            )),
        onRefresh: () async => refreshTimeLineList());
  }

  Widget timelineListStreamBuilder() {
    return StreamBuilder<APIResponse<TimeLineModel>>(
        stream: timelineBloc.timelineStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.Loading:
                {
                  if (currentPage == 1) {
                    return Center(
                      child: LoadingView().loader(),
                    );
                  } else {
                    if (timelineList.length > 0) {
                      return timelineListView();
                    }
                  }
                }
                break;

              case Status.Done:
                {
                  if (currentPage == 1) {
                    timelineList.clear();
                  }

                  lastPage = snapshot.data.data.meta.lastPage;
                  if (currentPage <= lastPage) {
                    currentPage = snapshot.data.data.meta.currentPage + 1;
                  }

                  if (snapshot.data.data.data.length > 0) {
                    timelineList = timelineList + snapshot.data.data.data;

                    if (timelineList.length > 0) {
                      return timelineListView();
                    } else {
                      return Center(
                        child: Text('Timeline updates not available.'),
                      );
                    }
                  }
                  break;
                }

              case Status.Error:
                AlertView()
                    .showAlertView(context, snapshot.data.message, () {});
            }
          }
        });
  }

  Widget timelineListView() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        // controller: scrollController,
        itemCount: timelineList.length,
        itemBuilder: (context, index) {
          switch (timelineList[index].mediaType) {
            case 1: //Image
              return TimelineImageView(timelineList[index]);

            default:
              return TimelineTextView(timelineList[index]);
          }
        });
  }

  refreshTimeLineList() {
    currentPage = 1;
    lastPage = 0;
    getTimelineList();
  }

  loadMore() {
    if (currentPage <= lastPage) {
      getTimelineList();
    }
  }

  getTimelineList() {
    Map<String, dynamic> params = {
      'projectId': projectID,
      'page': currentPage.toString(),
      'per_page': '7'
    };
    timelineBloc.getTimelineList(params);
  }
}
