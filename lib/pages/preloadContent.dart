import 'package:cinema_1888/core/models/genre_model.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:cinema_1888/pages/home.dart';

import 'package:get_it/get_it.dart';

class PreloadContent extends StatefulWidget {
  @override
  _PreloadContentState createState() => _PreloadContentState();
}

class _PreloadContentState extends State<PreloadContent> {
  APIResponse<GenreModel> _genreApiResponse;
  bool genreLoading = false;

  CinemaAPI get service => GetIt.I<CinemaAPI>();

  fetchGenre() async {
    setState(() {
      genreLoading = true;
    });

    _genreApiResponse = await service.getGenreList();
    if (!_genreApiResponse.error) {}
    setState(() {
      genreLoading = false;
    });
  }

  @override
  void initState() {
    fetchGenre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_) {
        if (genreLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (_genreApiResponse.error) {
          Container(
            height: 200,
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
                    onTap: fetchGenre,
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
        return Home(genreList: _genreApiResponse);
      }),
    );
  }
}
