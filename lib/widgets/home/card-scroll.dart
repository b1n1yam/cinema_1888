import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cinema_1888/core/models/movies_list.dart';
import 'package:cinema_1888/core/helpers/common.dart';

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final padding = 20.0;
  final verticalInset = 20.0;
  final List<Result> trending;
  CardScrollWidget(this.currentPage, this.trending);

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 12.0 / 16.0;
    var widgetAspectRatio = cardAspectRatio * 1.2;
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();
        //get the top 5 trending movies
        int size = 4;
        for (var i = 0; i < size; i++) {
          //reversing the order of items
          //so that the recent one is shown
          // on the top
          try {
            Result currentItem = trending[((i - 4) * -1) - 1];

            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                            "http://image.tmdb.org/t/p/w500/${currentItem.posterPath}",
                            fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 4.0, // gap between adjacent chips
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      '${currentItem.voteAverage}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Colors.black87),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, top: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.5, 0.6, 0.8, 0.9, 1.0],
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                    currentItem.originalTitle.isNotEmpty
                                        ? currentItem.originalTitle
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontFamily: "SF-Pro-Text-Regular")),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                        '${getMonthString(formatDate(currentItem.releaseDate))} ${getDateNumSingle(formatDate(currentItem.releaseDate))}  ',
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    dot(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "${getYear(formatDate(currentItem.releaseDate))}",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          } catch (_) {
            print("movie title doesnt exist");
          }
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }

  Widget dot() {
    return Container(
        height: 5.0,
        width: 5.0,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ));
  }
}
