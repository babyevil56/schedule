import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:schedule/components/appbar.dart';
import 'package:schedule/models/Schedule.dart';
import 'package:schedule/constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:schedule/screen/home.dart';

class ScheduleDetails extends StatefulWidget {
  ScheduleDetails({
    Key? key,
    required this.currentSchedule,
    this.elementIndex = -1
  }) : super(key: key);

  List<ScheduleObj> currentSchedule = [];
  int elementIndex;

  @override
  _ScheduleDetails createState() => _ScheduleDetails();
}

class _ScheduleDetails extends State<ScheduleDetails> {
  bool newSchedule = true;
  late TextEditingController _toDoList, _startDatepicker, _endDatepicker;
  ScheduleObj newScheduleObj = ScheduleObj();

  @override
  void initState() {
    super.initState();
    _toDoList = new TextEditingController();
    _startDatepicker = new TextEditingController();
    _endDatepicker = new TextEditingController();
    if (widget.elementIndex > -1) {
      newSchedule = false;
      newScheduleObj = widget.currentSchedule[widget.elementIndex];

      _startDatepicker.text = returnFormattedTime(newScheduleObj.startDateFormat());
      _endDatepicker.text = returnFormattedTime(newScheduleObj.endDateFormat());
      _toDoList.text = newScheduleObj.msg;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: RedirectAppBar(
        onPress: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(
                    currentSchedule: widget.currentSchedule,
                  ),
            ),
          );
        },
        newSchedule: newSchedule,
      ),
      body: Container(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("To-Do-Title"),
                  TextField(
                    controller: _toDoList,
                    maxLines: 7,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Please key in your To-Do-List here"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("To-Do-Title"),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime:DateTime.now(),
                          currentTime: newSchedule ? DateTime.now() : newScheduleObj.startDateFormat(),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            setState(() {
                              newScheduleObj.startDate = date.toString();
                              _startDatepicker.value =
                                  TextEditingValue(
                                      text: returnFormattedTime(date));
                            });
                          },
                          locale: LocaleType.en);
                    },
                    child: AbsorbPointer(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _startDatepicker,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("To-Do-Title"),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now().add(Duration(days: 1)),
                          currentTime: newSchedule ? DateTime.now().add(Duration(days: 1)) : newScheduleObj.endDateFormat(),
                          onConfirm: (date) {
                            setState(() {
                              newScheduleObj.endDate = date.toString();
                              _endDatepicker.value =
                                  TextEditingValue(
                                      text: returnFormattedTime(date));
                            });
                          }, locale: LocaleType.en);
                    },
                    child: AbsorbPointer(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _endDatepicker,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  newScheduleObj.msg = _toDoList.text;

                  if(newSchedule){
                    widget.currentSchedule.add(newScheduleObj);
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomePage(
                            currentSchedule: widget.currentSchedule,
                          ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Center(
                    child: Text(
                      (newSchedule ? "Create Now" : "Edit"),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String returnFormattedTime(DateTime date) {
    DateFormat formatter = DateFormat('dd MMM yyyy');
    String monthAbbr = formatter.format(date);
    return monthAbbr;
  }
}
