// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';
import './time_reducer.dart';

ScheduleForListing unitFromJson(String str) =>
    ScheduleForListing.fromJson(json.decode(str));

class ScheduleForListing {
  ScheduleForListing({this.id, this.date, this.times});

  String id;
  String date;
  List<TimeReducer> times;

  factory ScheduleForListing.fromJson(Map<String, dynamic> json) {
    //iterating throught list of times objects
    var timesList = json['times'] as List;
    List<TimeReducer> reducedSchedule =
        timesList.map((i) => TimeReducer.fromJson(i)).toList();

    return ScheduleForListing(
      id: json["_id"],
      date: json["date"],
      times: reducedSchedule,
    );
  }
}
