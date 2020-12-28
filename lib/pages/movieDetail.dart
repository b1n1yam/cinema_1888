import 'package:flutter/material.dart';
import 'package:cinema_1888/core/helpers/colors.dart';
import 'package:cinema_1888/widgets/movie-detail/content-page.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentPage(),
    );
  }
}
