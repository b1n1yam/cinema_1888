// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';
import './time_reducer.dart';

String unitToJson(TicketCrate data) => json.encode(data.toJson());

class TicketCrate {
  TicketCrate({
    this.title,
    this.price,
    this.seat,
  });

  String title;
  String price;
  List<String> seat;

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "seat": seat,
      };
}
