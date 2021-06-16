import 'package:demo_app/models/timeline_model.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'timeline_image_view.dart';

class TimelineTextView extends StatefulWidget {

  TimelineDataModel timelineUpdateInfo;

  TimelineTextView(this.timelineUpdateInfo);

  @override
  _TimelineTextViewState createState() => _TimelineTextViewState();
}

class _TimelineTextViewState extends State<TimelineTextView> {
  @override
  Widget build(BuildContext context) {
    return timelineTextView();
  }

  Widget timelineTextView() {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          topView(widget.timelineUpdateInfo.updatedAt, widget.timelineUpdateInfo.description),
          Text(
            widget.timelineUpdateInfo.description,
            style: CommonTextField()
                .commonTextStyle(Colors.black87, 15, FontWeight.normal),
          ),
        ],
      ),
    ));
  }
}
