import 'package:demo_app/blocs/subscribed_project_bloc.dart';
import 'package:demo_app/models/project_list_model.dart';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/generic_class/generic_button.dart';
import 'package:demo_app/utils/generic_class/generic_text.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class SubscribedProjectListScreen extends StatefulWidget {
  @override
  _SubscribedProjectListScreenState createState() =>
      _SubscribedProjectListScreenState();
}

class _SubscribedProjectListScreenState
    extends State<SubscribedProjectListScreen> {
  List<ProjectDataModel> projectList;

  SubscribedProjectBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = SubscribedProjectBloc();

    projectList = [];
    bloc.getSubscribedProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribed Projects'),
      ),
      body: streamBuilderView(),
    );
  }

  Widget streamBuilderView() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder<APIResponse<List<ProjectDataModel>>>(
            stream: bloc.subscribedProjectStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.Loading:
                    return LoadingView().loader();
                  case Status.Done:
                    projectList = snapshot.data.data;
                    return projectListView();
                  case Status.Error:
                    break;
                }
              }
            }));
  }

  Widget projectListView() {
    return ListView.builder(
        itemCount: projectList.length,
        itemBuilder: (context, index) {
          return projectListCell(projectList[index]);
        });
  }

  Widget projectListCell(ProjectDataModel projectInfo) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText().genericText(
                projectInfo.projectName, Colors.black87, 14, FontWeight.w600,
                padding: EdgeInsets.only(bottom: 7)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('images/Home/ic_location_projects.png'),
                  width: 15,
                  height: 15,
                  color: AppColor.AppTheme,
                ),
                Expanded(
                  child: CommonText().genericText(
                      projectInfo.address, Colors.black87, 12, FontWeight.w400),
                ),
                // Spacer(),
                CommonButton().gradientThemeButton(
                    'UNSUBSCRIBE',
                    Colors.white,
                    12,
                    FontWeight.w600,
                    100,
                    30,
                    AppColor.YellowGradient,
                    AppColor.OrangeGradient,
                    () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
