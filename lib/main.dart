import 'package:demo_app/repository/country_repository.dart';
import 'package:demo_app/view/LRF/tutorial_screen.dart';
import 'package:demo_app/view/tabbar/tab_pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/constant.dart';

Future<void> main() async {
  // CountryRepository countryRepository = CountryRepository();
  // countryRepository.getCountryList();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('UserToken');
  print('======= $token');
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  var token = "";

  MyApp({this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: token == null ? TutorialView() : TabPages(),
    );
  }
}
