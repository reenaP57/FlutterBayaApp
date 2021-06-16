import 'package:demo_app/view/Home/home_screen.dart';
import 'package:demo_app/view/Notification/notification_screen.dart';
import 'package:demo_app/view/Profile/my_profile_screen.dart';
import 'package:demo_app/view/Setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabNavigationItem {
  final Widget page;
  final ImageIcon icon;
  final String title;

  TabNavigationItem(
      {@required this.page, @required this.icon, @required this.title});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: HomeScreen(),
            icon: ImageIcon(AssetImage('images/Tabbar/ic_home.png')),
            title: 'Home'),
        TabNavigationItem(
            page: NotificationScreen(),
            icon: ImageIcon(AssetImage('images/Tabbar/ic_notification.png')),
            title: 'Notification'),
        TabNavigationItem(
            page: SettingScreen(),
            icon: ImageIcon(AssetImage('images/Tabbar/ic_setting.png')),
            title: 'Setting'),
        TabNavigationItem(
            page: MyProfileScreen(),
            icon: ImageIcon(AssetImage('images/Tabbar/ic_profile.png')),
            title: 'Profile'),
      ];
}
