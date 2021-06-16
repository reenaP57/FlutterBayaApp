import 'dart:ui';

import 'package:demo_app/models/timeline_model.dart';
import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/date_format.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/helper_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class TimelineImageView extends StatefulWidget {
  TimelineDataModel timelineUpdateInfo;

  TimelineImageView(this.timelineUpdateInfo);

  @override
  _TimelineImageViewState createState() => _TimelineImageViewState();
}

class _TimelineImageViewState extends State<TimelineImageView> {
  PageController pageController = PageController();
  double currentPage = 0;
  final currentPageNotifier = ValueNotifier<int>(0);

  List<String> images;

  @override
  void initState() {
    super.initState();

    images = [
      'https://api.thebayacompany.com/img/project/17/kPH31570275427.jpg',
      'https://api.thebayacompany.com/img/project/16/AycH1557985813.jpg',
      'https://api.thebayacompany.com/img/project/15/Cstz1557985787.jpg'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return timelineImageView();
  }

  Widget timelineImageView() {
    return Padding(
        padding: EdgeInsets.only(top: 7),
        child: Card(
          child: Container(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                topView(widget.timelineUpdateInfo.updatedAt, widget.timelineUpdateInfo.description),
                pageView(),
                pageIndicatorView(),
                Text(
                  widget.timelineUpdateInfo.description,
                  style: CommonTextField()
                      .commonTextStyle(Colors.black87, 15, FontWeight.normal),
                ),
              ],
            ),
          )),
        ));
  }

  Widget pageView() {
    return SizedBox(
      width: screenWidth(context) - 40,
      height: 150,
      child: PageView.builder(
          controller: pageController,
          itemCount: widget.timelineUpdateInfo.media.length,
          itemBuilder: (context, index) {
            return imageView(widget.timelineUpdateInfo.media[index]);
          },
          onPageChanged: (int page) {
            setState(() {
              currentPageNotifier.value = page;
            });
          }),
    );
  }

  Widget imageView(String img) {
    return Container(
      width: screenWidth(context) - 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(img, fit: BoxFit.fill),
      ),
    );
  }

  Widget pageIndicatorView() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CirclePageIndicator(
        currentPageNotifier: currentPageNotifier,
        itemCount: widget.timelineUpdateInfo.media.length,
        dotColor: Colors.grey,
        selectedDotColor: AppColor.AppTheme,
        dotSpacing: 3,
        size: 5,
      ),
    );
  }
}

Widget topView(int updatedT, String description) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        ImageIcon(
          AssetImage('images/Home/ic_calendar.png'),
          color: AppColor.AppTheme,
        ),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              color: Color.fromRGBO(220, 255, 224, 0),
              child: Text(
                DateFormatter().getDateWithFormat(updatedT, 'dd-MMM-YYYY'),
                style: CommonTextField()
                    .commonTextStyle(Colors.black87, 12, FontWeight.normal),
              ),
            )),
        Spacer(),
        InkWell(
          onTap: () {
            shareOnSocial(description);
          },
          child: Image(
            image: AssetImage('images/Home/ic_share.png'),
            width: 15,
            height: 15,
          ),
        )
      ],
    ),
  );
}
