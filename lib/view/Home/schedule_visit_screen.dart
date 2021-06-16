import 'package:demo_app/utils/generic_class/generic_text.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class ScheduleVisitScreen extends StatefulWidget {
  @override
  _ScheduleVisitScreenState createState() => _ScheduleVisitScreenState();
}

class _ScheduleVisitScreenState extends State<ScheduleVisitScreen> {
  var slot1TimeController = TextEditingController();
  var slot2TimeController = TextEditingController();
  var slot3TimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Visit'),
      ),
      body: scheduleVisitView(),
    );
  }

  Widget scheduleVisitView() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/LRF/bg.jpg'), fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: CommonText().genericText(
                    'Please select three different date & time slots, our team will check their availability and select one of those. Time slots are between 10 am - 6:30 pm. You can book appointments 24 hours from the current time.',
                    Colors.black87,
                    14,
                    FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: TextField(
                  readOnly: true,
                  controller: slot1TimeController,
                  decoration: CommonTextField().appDecorationStyle(
                      'Time slot1',
                      'Time slot1',
                      FontWeight.normal,
                      FontWeight.normal,
                      14,
                      13,
                      Colors.grey,
                      Colors.red,
                      5),
                  onTap: () async {
                    selectDate(slot1TimeController);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: TextField(
                  controller: slot2TimeController,
                  decoration: CommonTextField().appDecorationStyle(
                      'Time slot2',
                      'Time slot2',
                      FontWeight.normal,
                      FontWeight.normal,
                      14,
                      13,
                      Colors.grey,
                      Colors.red,
                      5),
                  onTap: () {
                    selectDate(slot2TimeController);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: TextField(
                  controller: slot3TimeController,
                  decoration: CommonTextField().appDecorationStyle(
                      'Time slot3',
                      'Time slot3',
                      FontWeight.normal,
                      FontWeight.normal,
                      14,
                      13,
                      Colors.grey,
                      Colors.red,
                      5),
                  onTap: () {
                    selectDate(slot3TimeController);
                  },
                ),
              )
            ],
          ),
        ));
  }

  selectDate(TextEditingController controller) async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (date != null) {
      String dateTime = DateFormat('dd-MM-yyyy hh:mm').format(date);

      setState(() {
        controller.text = dateTime;
      });
    }
  }
}
