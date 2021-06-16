import 'package:demo_app/blocs/project_list_bloc.dart';
import 'package:demo_app/blocs/subscribed_project_bloc.dart';
import 'package:demo_app/models/project_list_model.dart';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/utils/alertview.dart';
import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/generic_class/generic_button.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final scrollController = ScrollController();
  ProjectListBloc bloc;
  SubscribedProjectBloc subscribedProjectBloc;

  List<ProjectDataModel> projectList;

  int currentPage = 1;
  int lastPage = 0;
  bool isLoadMore = false;

  @override
  initState() {
    super.initState();
    projectList = [];

    //...Load More
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        loadMore();
      }
    });

    bloc = ProjectListBloc();
    subscribedProjectBloc = SubscribedProjectBloc();

    pullToRefresh();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: buildStream(),
    );
  }

  Widget buildStream() {
    return RefreshIndicator(
        backgroundColor: AppColor.AppTheme,
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: StreamBuilder<APIResponse<ProjectListModel>>(
              stream: bloc.projectStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.Loading:
                      return LoadingView().loader();
                    case Status.Done:
                      {
                        if (currentPage == 1) {
                          projectList.clear();
                        }

                        final metaData = snapshot.data.data.meta;
                        lastPage = metaData.last_page;
                        if (metaData.current_page <= lastPage) {
                          currentPage = metaData.current_page + 1;
                        }

                        var data = snapshot.data.data.data;

                        if (data.length != 0) {
                          projectList = projectList + data;
                          if (projectList.length > 0) {
                            return projectListView();
                          } else {
                            return Center(
                              child: Text('There is no have any projects.'),
                            );
                          }
                        }
                      }
                      break;

                    case Status.Error:
                      break;
                  }
                } else {
                  return LoadingView().loader();
                }
              },
            )),
        onRefresh: () async => pullToRefresh());
  }

  Widget projectListView() {
    return Container(
        height: screenHeight(context),
        child: ListView.builder(
            controller: scrollController,
            itemCount: projectList.length,
            itemBuilder: (BuildContext context, int index) {
              return projectCell(projectList[index]);
            }));
  }

  Widget projectCell(ProjectDataModel projectInfo) {
    return Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Image.network(projectInfo.projectImage, height: 194,
                      loadingBuilder: (context, child, loadingProcess) {
                        if (loadingProcess == null) return child;

                        return Container(
                            width: 15,
                            height: 15,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.AppTheme,
                              ),
                            ));
                      })),
              Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        projectInfo.projectName,
                        style: CommonTextField().commonTextStyle(
                            Colors.black87, 16, FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                      Spacer()
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('images/Home/ic_location_projects.png'),
                      width: 18,
                      height: 18,
                      color: null,
                    ),
                    Text(projectInfo.shortLocation,
                        style: CommonTextField().commonTextStyle(
                            Colors.black87, 15, FontWeight.w400),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton().gradientThemeButton(
                        (projectInfo.isSubscribe == 1)
                            ? 'UNSUBSCRIBE'
                            : 'SUBSCRIBE',
                        Colors.white,
                        11,
                        FontWeight.w500,
                        95,
                        28,
                        AppColor.YellowGradient,
                        AppColor.OrangeGradient,
                            () {
                          var updatedProjectInfo = projectInfo;
                          updatedProjectInfo.isSubscribe =
                          (updatedProjectInfo.isSubscribe == 1) ? 0 : 1;

                          int index = projectList.indexOf(projectInfo);

                          setState(() {
                            projectList[index] = updatedProjectInfo;
                          });
                          subscribedUnsubscribedProject({
                            'projectId': projectInfo.projectId.toString(),
                            'type': updatedProjectInfo.isSubscribe.toString()
                          });
                        }),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('MahaRERA:',
                            style: CommonTextField().commonTextStyle(
                                Colors.black87, 13, FontWeight.w600),
                            textAlign: TextAlign.left),
                        Text(projectInfo.reraNumber,
                            style: CommonTextField().commonTextStyle(
                                Colors.grey, 13, FontWeight.w400),
                            textAlign: TextAlign.left),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  pullToRefresh() {
    currentPage = 1;
    bloc.getProjectList({'page': currentPage.toString(), 'per_page': '3'});
  }

  loadMore() {
    if (currentPage <= lastPage) {
      bloc.getProjectList({'page': currentPage.toString(), 'per_page': '3'});
    }
  }

  getProjectList(String page, bool isInitState) {
    if (isInitState) {
      LoadingView().showLoader(true, context);
    }

    bloc.getProjectList({'page': page});

    bloc.projectStream.listen((snapShot) {
      switch (snapShot.status) {
        case Status.Loading:
          break;
        case Status.Done:
          {
            LoadingView().showLoader(false, context);

            if (currentPage == 1) {
              projectList.clear();
            }

            var data = (snapShot.data.data as List<ProjectDataModel>);

            if (data.length > 0) {
              setState(() {
                projectList = projectList + data;
              });
            }

            final metaData = snapShot.data.meta as ProjectMetaModel;

            if (metaData.current_page <= metaData.last_page) {
              currentPage = metaData.current_page + 1;
            }
          }
          break;
        case Status.Error:
          AlertView().showAlertView(context, snapShot.message, () {});
      }
    });
  }

  subscribedUnsubscribedProject(Map<String, dynamic> params) {
    subscribedProjectBloc.subscribedUnsubscribedProject(params);

    subscribedProjectBloc.subscribedUnsubscribedStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.Loading:
          break;
        case Status.Done:
          break;
        case Status.Error:
          break;
      }
    });
  }

}
