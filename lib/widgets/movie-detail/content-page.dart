import 'package:cinema_1888/core/models/movie_detail_model.dart';
import 'package:cinema_1888/pages/buy-ticket.dart';
import 'package:flutter/material.dart';
import 'package:cinema_1888/core/helpers/colors.dart';
import './get-geners.dart';

class ContentPage extends StatefulWidget {
  final MovieDetailModel movie;

  const ContentPage({Key key, this.movie}) : super(key: key);
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 360,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                        "http://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter)),
            ),
            Positioned(
              left: 10,
              top: 15,
              child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 28.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Positioned(
              top: 280,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 8),
                width: _width,
                height: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Color(0xFF1b1e44).withOpacity(0.01),
                    Color(0xFF1b1e44).withOpacity(0.3),
                    Color(0xFF1b1e44).withOpacity(0.6),
                    Color(0xFF1b1e44).withOpacity(0.9),
                    Color(0xFF1b1e44)
                  ],
                )),
              ),
            ),
            Positioned(
              left: 20,
              top: 250,
              child: Container(
                  width: _width - 40,
                  child: new Text(
                    widget.movie.originalTitle,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
            Positioned(
                left: 20,
                top: 300,
                child: GetGeners(genres: widget.movie.genres)),
            Positioned(
              left: 20,
              right: 20,
              top: 370,
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 0.5,
                  color: Colors.black38),
            ),
            Positioned(
              top: 370,
              child: Container(
                  margin: EdgeInsets.only(left: 20),
                  width: _width,
                  height: 120,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      widget.movie.runtime.toString(),
                                      style: TextStyle(
                                          color: popularityColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    new Text("minutes",
                                        style: TextStyle(color: Colors.white))
                                  ]),
                            ),
                          ),
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,
                                        color: iconColor, size: 28),
                                    RichText(
                                      text: TextSpan(
                                          text: widget.movie.voteAverage
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          children: [
                                            TextSpan(
                                                text: '/ 10',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14))
                                          ]),
                                    )
                                  ]),
                            ),
                          ),
                          Container(
                            width: (_width - 40) / 3,
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Text(
                                      widget.movie.popularity.toString(),
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    new Text("Popularity",
                                        style: TextStyle(color: Colors.white))
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 500,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          new Text('Overview',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: new Text(widget.movie.overview,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Theme.of(context).buttonTheme.height + 20,
                width: double.infinity,
                child: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('Continue to seat selector ',
                            style: TextStyle(fontSize: 18)),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BuyTicket(
                          title: widget.movie.originalTitle.toString()),
                    ),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
