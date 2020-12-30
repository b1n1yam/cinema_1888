// ##  Properties Abstract class
// holding declaration of property endpoints
import 'package:cinema_1888/core/models/get_ticket.dart';
import 'package:cinema_1888/core/models/movie_detail_model.dart';
import 'package:cinema_1888/pages/movieDetail.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:cinema_1888/core/models/schedule_list.dart';
import 'package:cinema_1888/core/models/create_ticket.dart';
import 'package:cinema_1888/core/models/trending_movies.dart';
import 'package:cinema_1888/core/models/genre_model.dart';

abstract class CinemaAPI {
  /// **endpoint:** /movie
  ///
  /// **method:** __GET__
  ///
  // **desc:** gets a list of schedules from api
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<List<ScheduleForListing>>> getSchedules();

  /// **endpoint:** /reserve/:date/:time
  ///
  /// **method:** __GET__
  ///
  // **desc:** reserves a seat for a particular date and returns the tiket content
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<GetTicket>> createTicket(
      TicketCrate ticket, String date, String time);

  /// **endpoint:** https://api.themoviedb.org/3/trending/all/day
  ///
  /// **method:** __GET__
  ///
  // **desc:**  returns trending movie list
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<Trending>> getTrending();

  /// **endpoint:** https://api.themoviedb.org/3/genre/movie/list
  ///
  /// **method:** __GET__
  ///
  // **desc:**  returns list of genres
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<GenreModel>> getGenreList();

  /// **endpoint:** https://api.themoviedb.org/3/popular
  ///
  /// **method:** __GET__
  ///
  // **desc:**  returns list of popular movies
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<Trending>> getPopularMovies();

  /// **endpoint:** https://api.themoviedb.org/3/movie/:id
  ///
  /// **method:** __GET__
  ///
  // **desc:**  returns a single movies detail
  ///
  /// Throws a [APIResponse.Error] for all error codes.
  Future<APIResponse<MovieDetailModel>> getMovieDetail(int id);
}
