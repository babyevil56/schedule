import 'package:flutter/material.dart';
import 'package:schedule/models/Schedule.dart';
import 'package:intl/intl.dart';
import 'package:schedule/app/enum/ScheduleStatusType.dart';
import 'dart:async';

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({Key? key, required this.scheduleObj}) : super(key: key);

  final ScheduleObj scheduleObj;

  @override
  _ScheduleWidget createState() => _ScheduleWidget();
}

class _ScheduleWidget extends State<ScheduleWidget> {
  bool scheduleCompleted = false;
  int currentSeconds = 0;
  final interval = const Duration(seconds: 1);

  int timerMaxSeconds = 0;
  late Timer _timer;

  String get timerText =>
      '${(((timerMaxSeconds - currentSeconds) ~/ 60) ~/ 60).toString().padLeft(2, '0')} hrs ${(((timerMaxSeconds - currentSeconds) ~/ 60) % 60).toString().padLeft(2, '0')} min  ';

  startTimeout() {
    timerMaxSeconds = daysBetween(DateTime.now(),
    widget.scheduleObj.startDateFormat());
    var duration = interval;
    _timer = new Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: new BoxDecoration(
        color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 3.0, top: 20.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.scheduleObj.msg,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Wrap(
                  spacing: 40.0,
                  runSpacing: 40.0,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Start Date"),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            returnFormattedTime(
                                widget.scheduleObj.startDateFormat()),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("End Date"),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            returnFormattedTime(
                                widget.scheduleObj.endDateFormat()),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Time Left"),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            timerText,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13.0,
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: 20.0, right: 3.0, top: 0.0, bottom: 0.0),
            color: Color(0xFFe7e3cf),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Status: ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: widget.scheduleObj.scheduleStatus ==
                                ScheduleStatusType.Incomplete
                            ? "Incomplete"
                            : "Complete",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text("Tick if completed"),
                    Checkbox(
                        value: widget.scheduleObj.scheduleStatus ==
                                ScheduleStatusType.Incomplete
                            ? false
                            : true,
                        onChanged: (bool? value) {
                          setState(() {
                            widget.scheduleObj.scheduleStatus =
                                widget.scheduleObj.scheduleStatus ==
                                        ScheduleStatusType.Incomplete
                                    ? ScheduleStatusType.Complete
                                    : ScheduleStatusType.Incomplete;
                          });
                        })
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String returnFormattedTime(DateTime date) {
    DateFormat formatter = DateFormat('dd MMM yyyy');
    String monthAbbr = formatter.format(date);
    return monthAbbr;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    print((to.difference(from).inSeconds));
    return (to.difference(from).inSeconds);
  }
}
