import 'dart:convert';

import 'package:cinema_1888/core/constants/constants.dart';
import 'package:cinema_1888/core/models/genre_model.dart';
import 'package:cinema_1888/core/models/get_ticket.dart';
import 'package:cinema_1888/core/models/create_ticket.dart';
import 'package:cinema_1888/core/models/movie_detail_model.dart';
import 'package:cinema_1888/core/models/trending_movies.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:cinema_1888/core/models/schedule_list.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:http/http.dart' as http;

class CinemaApiImplimentation extends CinemaAPI {
  static const API = Constants.API;
  static const BASE_URL = Constants.BASE_URL;
  static const API_KEY = Constants.API_KEY;
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

  @override
  Future<APIResponse<Trending>> getTrending() {
    return http
        .get('${BASE_URL}trending/all/day?api_key=$API_KEY', headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        final jsonData = Trending.fromJson(json.decode(data.body));
        return APIResponse<Trending>(data: jsonData);
      }

      return APIResponse<Trending>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<Trending>(
            error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<GenreModel>> getGenreList() {
    return http
        .get('${BASE_URL}genre/movie/list?api_key=$API_KEY', headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        final jsonData = GenreModel.fromJson(json.decode(data.body));
        return APIResponse<GenreModel>(data: jsonData);
      }

      return APIResponse<GenreModel>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<GenreModel>(
            error: true, errorMessage: 'An error occured'));
  }

  @override
  Future<APIResponse<Trending>> getPopularMovies() {
    return http
        .get('${BASE_URL}movie/popular?api_key=$API_KEY', headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        final jsonData = Trending.fromJson(json.decode(data.body));
        return APIResponse<Trending>(data: jsonData);
      }

      return APIResponse<Trending>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<Trending>(
            error: true, errorMessage: 'An error occured'));
  }

  @override
  Future<APIResponse<MovieDetailModel>> getMovieDetail(int id) {
    return http
        .get('${BASE_URL}movie/$id?api_key=$API_KEY', headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        print(data.body);
        final jsonData = MovieDetailModel.fromJson(json.decode(data.body));
        return APIResponse<MovieDetailModel>(data: jsonData);
      }

      return APIResponse<MovieDetailModel>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<MovieDetailModel>(
            error: true, errorMessage: 'An error occured'));
  }
}
