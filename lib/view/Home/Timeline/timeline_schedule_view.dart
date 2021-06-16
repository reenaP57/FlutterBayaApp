import 'package:demo_app/blocs/timeline_bloc.dart';
import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/custom_scroll_physics.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/helper_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:demo_app/models/project_list_model.dart';

class TimelineScheduleView extends StatefulWidget {
  List<ProjectDataModel> subscribedProjectList;
  Function(String) callback;

  TimelineScheduleView(this.subscribedProjectList, this.callback);

  @override
  _TimelineScheduleViewState createState() => _TimelineScheduleViewState();
}

class _TimelineScheduleViewState extends State<TimelineScheduleView> {
  final scrollController = ScrollController();

  TimelineBloc timelineBloc;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timelineBloc = TimelineBloc();
  }

  @override
  dispose() {
    super.dispose();
    scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timelineScheduleView(),
    );
  }

  Widget timelineScheduleView() {
    return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification) {
            onEndScroll(scrollNotification.metrics);
          }
        },
        child: ListView.builder(
            shrinkWrap: true,
            physics:
                CustomScrollPhysics(itemDimension: screenWidth(context) - 120),
            itemCount: widget.subscribedProjectList.length,
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                    width: screenWidth(context) - 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            projectName(widget
                                .subscribedProjectList[index].projectName),
                            projectSubscribeBtn(index)
                          ],
                        ),
                        projectLocation(
                            widget.subscribedProjectList[index].shortLocation),
                        mahaReraNumber(
                            widget.subscribedProjectList[index].reraNumber),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 15),
                          child: Row(
                            children: [
                              callBtn(
                                  widget.subscribedProjectList[index].mobileNo),
                              SizedBox(
                                width: 10,
                              ),

                              // if (subscribedProjectList[index].isSoldOut == 1) {
                              //   // soldOutText()
                              // }
                            ],
                          ),
                        )
                      ],
                    )),
              );
            }));
  }

  Widget projectName(String projectName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4, left: 10, top: 10),
      child: Text(
        projectName,
        style: CommonTextField().commonTextStyle(
          Colors.black87,
          15,
          FontWeight.w600,
        ),
      ),
    );
  }

  Widget projectSubscribeBtn(int index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          var projectInfo = widget.subscribedProjectList[index];
          projectInfo.isSubscribe = (projectInfo.isSubscribe == 1) ? 0 : 1;

          setState(() {
            widget.subscribedProjectList[index] = projectInfo;
          });
        },
        child: Container(
          width: 20,
          height: 20,
          child: Image(
            image: AssetImage(
                (widget.subscribedProjectList[index].isSubscribe == 1)
                    ? 'images/Home/ic_select_circle.png'
                    : 'images/Home/ic_unselect_circle.png'),
          ),
        ),
      ),
    );
  }

  Widget projectLocation(String location) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4, left: 10),
      child: Text(
        location,
        style: CommonTextField().commonTextStyle(
          Colors.black87,
          15,
          FontWeight.w600,
        ),
      ),
    );
  }

  Widget mahaReraNumber(String reraNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4, left: 10),
          child: Text(
            'MahaRERA:',
            style: CommonTextField().commonTextStyle(
              Colors.black87,
              13,
              FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 4, left: 10),
          child: Text(
            reraNumber,
            style: CommonTextField().commonTextStyle(
              Colors.grey,
              13,
              FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget callBtn(String mobileNo) {
    return Container(
      width: 40,
      height: 25,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColor.AppTheme),
        ),
        child: Image(
          image: AssetImage('images/Home/ic_call.png'),
        ),
        onPressed: () {
          makePhoneCall(mobileNo);
        },
      ),
    );
  }

  Widget soldOutText() {
    return Text(
      'SOLD OUT',
      style: CommonTextField().commonTextStyle(
        AppColor.AppTheme,
        14,
        FontWeight.w600,
      ),
    );
  }

  onEndScroll(ScrollMetrics metrics) {
    print("Scroll End");
    currentIndex = getIndexOnListViewScroll();
    widget.callback(
        widget.subscribedProjectList[currentIndex].projectId.toString());
  }

  int getIndexOnListViewScroll() {
    double itemWidth = (screenWidth(context) - 120);
    double offset = scrollController.offset;
    return ((offset - itemWidth) / itemWidth).ceil() < 0
        ? 0
        : ((offset - itemWidth) / itemWidth).ceil() + 1;
  }
}
