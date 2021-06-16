import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/material.dart';
import 'tab_navigation_item.dart';

class TabPages extends StatefulWidget {
  @override
  _TabPagesState createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this.currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.title,
              ),
          ],
        ));
  }
}
