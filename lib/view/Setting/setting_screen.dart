import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> settingOptions = [
    'Edit Profile',
    'Change Password',
    'Push Notification',
    'Email Notification',
    'SMS Notification',
    'Terms & Condition',
    'Privacy Policy',
    'App Support',
    'About Us',
    'Rate App',
    'Log Out'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: settingView());
  }

  Widget settingView() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/LRF/bg.jpg'), fit: BoxFit.fill)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: settingOptions.length,
            itemBuilder: (context, index) {
              return settingCard(settingOptions[index],
                  (index == 2 || index == 3 || index == 4));
            }),
      ),
    );
  }

  Widget settingCard(String title, bool isShowSwitch) {
    return Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Container(
          height: 60,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: CommonTextField()
                        .commonTextStyle(Colors.black87, 16, FontWeight.w500),
                  ),
                ),
                if (isShowSwitch)
                  Visibility(
                      visible: isShowSwitch,
                      child: Switch(value: true, onChanged: (isChanged) {})),
                if (!isShowSwitch)
                  Visibility(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                    visible: !isShowSwitch,
                  )
              ],
            ),
          ),
        ));
  }
}
