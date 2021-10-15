import 'package:schedule/app/enum/ScheduleStatusType.dart';
import 'package:intl/intl.dart';

class ScheduleObj {
  ScheduleObj(
      {this.startDate = "",
      this.endDate = "",
      this.msg = "",
      this.scheduleStatus = ScheduleStatusType.Incomplete});

  String startDate;
  String endDate;
  String msg;
  ScheduleStatusType scheduleStatus;

  DateTime startDateFormat(){
    return DateTime.parse(startDate);
  }

  DateTime endDateFormat(){
    return DateTime.parse(endDate);
  }
}
