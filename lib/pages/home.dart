import 'package:cinema_1888/core/models/genre_model.dart';
import 'package:cinema_1888/widgets/buy-ticket/const.dart';
import 'package:flutter/material.dart';

import 'package:cinema_1888/widgets/home/data.dart';
import 'package:cinema_1888/widgets/home/CustomIcons.dart';
import 'package:cinema_1888/widgets/home/card-scroll.dart';
import 'package:cinema_1888/widgets/home/Latest_movies.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:cinema_1888/core/models/trending_movies.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  final APIResponse<GenreModel> genreList;

  const Home({Key key, this.genreList}) : super(key: key);
  @override
  _HomeState createState() => new _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  var currentPage = images.length - 1.0;
  CinemaAPI get service => GetIt.I<CinemaAPI>();
  bool loading = false;
  bool loadingPopular = false;
  APIResponse<Trending> _apiResponse;
  APIResponse<Trending> _apiResponsePopular;
  fetchTrending() async {
    setState(() {
      loading = true;
    });

    _apiResponse = await service.getTrending();
    if (!_apiResponse.error) {}
    setState(() {
      loading = false;
    });
  }

  fetchPopular() async {
    setState(() {
      loadingPopular = true;
    });

    _apiResponsePopular = await service.getPopularMovies();
    if (!_apiResponsePopular.error) {
      print(_apiResponsePopular.data.results.toString());
    }
    setState(() {
      loadingPopular = false;
    });
  }

  @override
  void initState() {
    fetchTrending();
    fetchPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1b1e44),
          title: Center(
            child: Text(
              "1888 Cinema",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontFamily: "Calibre-Semibold",
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Trending",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFff6e6e),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("This week",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ),
                loading
                    ? Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                    : _apiResponse.error
                        ? Container(
                            height: 200,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "sorry something went wrong",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 12.0, bottom: 12.0),
                                  child: InkWell(
                                    onTap: fetchTrending,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Try again",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          )
                        : Stack(
                            children: <Widget>[
                              CardScrollWidget(
                                  currentPage, _apiResponse.data.results),
                              Positioned.fill(
                                child: PageView.builder(
                                  itemCount: images.length,
                                  controller: controller,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                    return Container();
                                  },
                                ),
                              )
                            ],
                          ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Favourite",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                      IconButton(
                        icon: Icon(
                          CustomIcons.option,
                          size: 12.0,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("Latest",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("9+ Stories",
                          style: TextStyle(color: Colors.blueAccent))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                loadingPopular
                    ? Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                    : _apiResponsePopular.error
                        ? Container(
                            height: 200,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "sorry something went wrong",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 12.0, bottom: 12.0),
                                  child: InkWell(
                                    onTap: fetchPopular,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 22.0, vertical: 6.0),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Text("Try again",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          )
                        : Container(
                            // wrap in Expanded
                            child: new ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: new List.generate(10, (int index) {
                                return PopularMovies(
                                    cardAspectRatio,
                                    _apiResponsePopular.data.results[index],
                                    widget.genreList);
                              }),
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
