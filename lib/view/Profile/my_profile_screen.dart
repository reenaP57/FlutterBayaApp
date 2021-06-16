import 'package:demo_app/utils/app_colors.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/generic_class/generic_button.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/view/Profile/subscribed_projectlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  List<String> profileOptions = [
    'Schedule a Visit',
    'My Subscribed Projects',
    'Visit Details'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: profileScreen(),
    );
  }

  Widget profileScreen() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/LRF/bg.jpg'), fit: BoxFit.fill)),
        width: screenWidth(context),
        child: Padding(
            padding: EdgeInsets.only(left: 20, top: 35),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userDetail('Reena Prajapati', Colors.black87, 15),
              userDetail('reena@gmail.com', Colors.grey, 15),
              userDetail('917777777777777', Colors.grey, 15),
              CommonButton().gradientThemeButton(
                  'EDIT PROFILE',
                  Colors.white,
                  12,
                  FontWeight.w600,
                  100,
                  30,
                  AppColor.YellowGradient,
                  AppColor.OrangeGradient,
                  () {}),
              profileOptionList()
            ])));
  }

  Widget userDetail(String title, Color color, double size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(
        title,
        style: CommonTextField().commonTextStyle(color, size, FontWeight.w500),
      ),
    );
  }

  // Widget editPorfileBtn() {
  //   return Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(3),
  //           gradient: LinearGradient(
  //               colors: [AppColor.YellowGradient, AppColor.OrangeGradient],
  //               begin: FractionalOffset.topLeft,
  //               end: FractionalOffset.bottomRight)),
  //       width: 100,
  //       height: 30,
  //       child: InkWell(
  //         onTap: () {},
  //         child: Center(
  //           child: userDetail('EDIT PROFILE', Colors.white, 12),
  //         ),
  //       ));
  // }

  Widget profileOptionList() {
    return Padding(
      padding: EdgeInsets.only(top: 35, right: 20),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: profileOptions.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                  height: 50,
                  child: Card(
                      child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: userDetail(
                            profileOptions[index], Colors.black87, 15),
                      )
                    ],
                  ))),
              onTap: () {
                switch (index) {
                  case 1:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SubscribedProjectListScreen()));
                }
              },
            );
          }),
    );
  }
}
