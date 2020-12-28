// ##  Properties Abstract class
// holding declaration of property endpoints
import 'package:cinema_1888/core/models/get_ticket.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:cinema_1888/core/models/schedule_list.dart';
import 'package:cinema_1888/core/models/create_ticket.dart';

abstract class CinemaAPI {
  /// **endpoint:** /movie
  ///
  /// **method:** __GET__
  ///
  // **desc:** gets a list of schedules from api
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<List<ScheduleForListing>>> getSchedules();

  /// **endpoint:** /movie
  ///
  /// **method:** __GET__
  ///
  // **desc:** gets a list of schedules from api
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<GetTicket>> createTicket(
      TicketCrate ticket, String date, String time);
}
