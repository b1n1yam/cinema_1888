import 'package:flutter/material.dart';
import 'ui/colors.dart';

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

class ContentPage extends StatefulWidget {
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
      child: Stack(
        children: [
          Container(
            height: 360,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage("assets/image_02.jpg"),
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.topCenter)),
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
            top: 220,
            child: Container(
                width: _width - 40,
                child: new Text(
                  "movie title",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
          Positioned(left: 20, top: 270, child: GetGeners()),
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
                                    "wssa",
                                    style: TextStyle(
                                        color: popularityColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  new Text("Popularity",
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
                                  Icon(Icons.star, color: iconColor, size: 28),
                                  RichText(
                                    text: TextSpan(
                                        text: "69",
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
                                    "wssa",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  new Text("Vote Count",
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
            top: 490,
            child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 0.5,
                color: Colors.black38),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 500,
            child: Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    new Text('Description',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    new Text(
                        'wssa ollo thos os the best movie ever i mean this guy just tried too kill the other huy and the whole thing is jus foSckin DIABOLOCAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class GetGeners extends StatefulWidget {
  @override
  _GetGenersState createState() => _GetGenersState();
}

class _GetGenersState extends State<GetGeners> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 8,
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems()
        ],
      ),
    );
  }

  Widget RowItems() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: new Text('sawads', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
