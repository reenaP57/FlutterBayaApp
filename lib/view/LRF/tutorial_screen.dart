import 'dart:ui';
import 'package:demo_app/repository/country_repository.dart';
import 'package:demo_app/utils/loading_view.dart';
import 'package:demo_app/view/LRF/signIn_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TutorialView extends StatefulWidget {
  @override
  _TutorialViewState createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  List<Map> tutorialData = [
    {
      "image": "images/Tutorial/tutorial1.png",
      'title': 'Timeline',
      "desc": 'See the updates for all our projects with\n\n'
          'construction photos View the percentage\n\n'
          'completionnof each project Easy one tap\n'
    },
    {
      "image": "images/Tutorial/tutorial2.png",
      'title': 'Project Details',
      "desc": 'View all The Baya Company projects\n\n'
          'and the detailsProject overviews,\n\n'
          'amenities, specifications,location advantage'
    },
    {
      "image": "images/Tutorial/tutorial3.png",
      'title': 'Schedule A Visit',
      "desc": 'Schedule a site visit for our\n\n '
          'projects Select up to 3 preferred date & time slots'
    }
  ];

  PageController _pageController = PageController();
  var currentPage = 0;
  CountryRepository countryRepository = CountryRepository();

  @override
  void initState() {
    super.initState();
    countryRepository.getCountryList();
  }

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial"),
      ),
      body: getListView(),
    );
  }

  Container getListView() {
    return Container(
      padding: EdgeInsets.only(bottom: 35),
      child: Column(
        children: [
          Flexible(
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: tutorialData.length,
                itemBuilder: (context, index) {
                  return getTutorialCell(tutorialData[index]);
                }),
          ),
          ElevatedButton(
            child: Text((currentPage == 2) ? 'Done' : 'Next',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(elevation: 5, primary: Colors.green),
            onPressed: () {
              moveToNextPage();
            },
          ),

          /* Two button code
          Center(
            child: Container(
              height: 100,
              // alignment: Alignment.center,
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text('Previous'),
                    style: ElevatedButton.styleFrom(elevation: 5),
                  )),
                  Container(
                    width: 35,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    child: Text('Next',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(elevation: 5),
                  )),
                ],
              ),
            ),
          )
          */
        ],
      ),
    );
  }

  Container getTutorialCell(Map info) {
    return Container(
      width: 375,
      child: Column(
        children: [
          Image(
            image: AssetImage(info['image']),
            width: 200,
            height: 200,
          ),
          Text(
            info['title'],
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 35,
          ),
          Text(
            info['desc'],
            style: TextStyle(fontSize: 14.0, color: Colors.green),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  void moveToNextPage() {

    if (currentPage == 2) {
      //...Redirect on login view
      navigateToLoginView();
    } else {
      setState(() {
        currentPage += 1;
        _pageController.animateToPage(currentPage,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      });
    }
  }

  void navigateToLoginView() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SignInView();
    }));
  }
}
