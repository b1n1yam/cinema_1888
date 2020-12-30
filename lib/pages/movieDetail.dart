import 'package:cinema_1888/core/models/movie_detail_model.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:cinema_1888/core/helpers/colors.dart';
import 'package:cinema_1888/widgets/movie-detail/content-page.dart';
import 'package:get_it/get_it.dart';
import 'package:cinema_1888/services/cinema_api.dart';

/// this file contains the logic of
/// showing a single movie's detail
class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  CinemaAPI get service => GetIt.I<CinemaAPI>();
  bool loading = false;
  bool loadingPopular = false;
  APIResponse<MovieDetailModel> _apiResponse;
  fetchMovieDetail() async {
    setState(() {
      loading = true;
    });

    _apiResponse = await service.getMovieDetail(widget.id);
    if (!_apiResponse.error) {
      print(_apiResponse.data.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchMovieDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (_) {
      if (loading) {
        return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Color(0xFF1b1e44),
                  Color(0xFF2d3447),
                ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    tileMode: TileMode.clamp)),
            child: Center(child: CircularProgressIndicator()));
      }
      if (_apiResponse.error) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color(0xFF1b1e44),
                Color(0xFF2d3447),
              ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  tileMode: TileMode.clamp)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "sorry something went wrong",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20, left: 12.0, bottom: 12.0),
                child: InkWell(
                  onTap: fetchMovieDetail,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text("Try again",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          )),
        );
      }
      return ContentPage(movie: _apiResponse.data);
    }));
  }
}
