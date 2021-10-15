import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/components/appbar.dart';
import 'package:schedule/constant.dart';
import 'package:schedule/components/scheduleWidget.dart';
import 'package:schedule/screen/scheduleDetails.dart';
import 'package:schedule/models/Schedule.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  HomePage({required this.currentSchedule});

  List<ScheduleObj> currentSchedule = [];

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticAppBar(),
      body: Container(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.currentSchedule.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleDetails(
                            currentSchedule: widget.currentSchedule,
                            elementIndex: widget.currentSchedule.indexOf(item),
                          ),
                        ),
                      );
                    },
                    child: ScheduleWidget(scheduleObj: item,),
                  );
                }).toList(),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleDetails(
                      currentSchedule: widget.currentSchedule,
                    ),
                  ),
                );
              },
              child: Container(
                  height: 40.0,
                  width: 40.0,
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  child: Icon(
                    IconData(57415, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
