import 'dart:convert';

import 'package:cinema_1888/core/constants/constants.dart';
import 'package:cinema_1888/core/models/get_ticket.dart';
import 'package:cinema_1888/core/models/create_ticket.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:cinema_1888/core/models/schedule_list.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:http/http.dart' as http;

class CinemaApiImplimentation extends CinemaAPI {
  static const API = Constants.API;
  static const headers = {
    'Content-Type': "application/json",
    "accept": "application/json"
  };
  @override
  Future<APIResponse<List<ScheduleForListing>>> getSchedules() {
    return http.get(API + '/').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final schedules = <ScheduleForListing>[];
        for (var item in jsonData) {
          schedules.add(ScheduleForListing.fromJson(item));
          print(item);
        }

        return APIResponse<List<ScheduleForListing>>(data: schedules);
      }

      return APIResponse<List<ScheduleForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((err) => APIResponse<List<ScheduleForListing>>(
        error: true, errorMessage: err.toString() ?? 'error occured'));
  }

  @override
  Future<APIResponse<GetTicket>> createTicket(
      TicketCrate ticket, String date, String time) {
    return http
        .put(API + '/reserve/$date/$time',
            headers: headers, body: json.encode(ticket.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        final jsonData = GetTicket.fromJson(json.decode(data.body));
        return APIResponse<GetTicket>(data: jsonData);
      }

      return APIResponse<GetTicket>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<GetTicket>(
            error: true, errorMessage: 'An error occured'));
  }
}
