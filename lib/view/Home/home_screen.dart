import 'package:demo_app/repository/project_list_repository.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/view/Home/Timeline/timeline_screen.dart';
import 'package:demo_app/view/Home/project_list_screen.dart';
import 'package:demo_app/view/Home/schedule_visit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var categoryList = [
    {'title': 'Timeline', 'image': 'images/Home/ic_timeline.png'},
    {'title': 'Projects', 'image': 'images/Home/ic_projects.png'},
    {'title': 'Schedule Visit', 'image': 'images/Home/ic_schedule_visit.png'},
    {'title': 'Documents', 'image': 'images/Home/ic_documents.png'},
    {'title': 'Maintenance', 'image': 'images/Home/ic_maintanance.png'},
    {'title': 'Refer Friend', 'image': 'images/Home/ic_refer-friend.png'}
  ];

  ProjectListRepository repository;

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: gridView());
  }

  Widget gridView() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/LRF/bg.jpg'),
        fit: BoxFit.fill,
      )),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 10,
          children: List.generate(categoryList.length, (index) {
            return InkWell(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimeLineScreen()));
                    break;
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectListScreen()));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleVisitScreen()));
                    break;
                }
              },
              child: gridViewCell(index),
            );
          }),
        ),
      ),
    );
  }

  Widget gridViewCell(int index) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(categoryList[index]['image']),
            width: 50,
            height: 50,
          ),
          Container(
            height: 10,
          ),
          Text(
            categoryList[index]['title'],
            style: CommonTextField()
                .commonTextStyle(Colors.black87, 17, FontWeight.w700),
          )
        ],
      ),
    );
  }
}
