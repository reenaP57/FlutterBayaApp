import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: notificationListView());
  }

  Widget notificationListView() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/LRF/bg.jpg'), fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              return notificationCell();
            }),
      ),
    );
  }

  Widget notificationCell() {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(7),
      child: Row(
        children: [
          Image(
            image: AssetImage('images/LRF/baya_logo.png'),
            width: 100,
            height: 100,
          ),
          Container(
            width: 10,
          ),
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Baya Victoria',
                  style: CommonTextField()
                      .commonTextStyle(Colors.black87, 15, FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'Your visit at 5:00 PM has been confirmed.',
                  style: CommonTextField()
                      .commonTextStyle(Colors.black87, 13, FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('images/Notification/ic_time.png'),
                      width: 15,
                      height: 15,
                    ),
                    Container(
                      width: 4,
                    ),
                    Text(
                      'Yesterday at 12:00 PM',
                      style: CommonTextField()
                          .commonTextStyle(Colors.grey, 12, FontWeight.w400),
                    )
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    ));
  }
}
