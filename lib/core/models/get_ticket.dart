// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';
import './time_reducer.dart';

GetTicket unitFromJson(String str) => GetTicket.fromJson(json.decode(str));

class GetTicket {
  GetTicket({
    this.title,
    this.price,
    this.id,
    this.seats,
  });

  String title;
  String price;
  String id;
  String seats;
  String date;
  String time;

  GetTicket.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    price = json['price'];
    seats = json['seat'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
  }
}
