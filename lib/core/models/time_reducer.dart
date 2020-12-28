import 'dart:convert';

TimeReducer documentFromJson(String str) =>
    TimeReducer.fromJson(json.decode(str));

class TimeReducer {
  String id;
  String time;
  String availability;
  List<String> reserved;

  TimeReducer({this.id, this.time, this.availability, this.reserved});

  TimeReducer.fromJson(Map<String, dynamic> json) {
    //iterating throught list of reserved
    var reservedList = json['reserved'] as List;
    List<String> reducedRecerved =
        reservedList.map((i) => i.toString()).toList();

    id = json['_id'];
    time = json['time'];
    availability = json['availability'];
    reserved = reducedRecerved;
  }
}
