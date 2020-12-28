import 'package:cinema_1888/services/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:cinema_1888/core/models/movies_list.dart';
import 'package:cinema_1888/core/helpers/common.dart';
import 'package:cinema_1888/core/models/genre_model.dart';

class PopularMovies extends StatelessWidget {
  final cardAspectRatio;
  final Result popular;
  final APIResponse<GenreModel> genreList;
  PopularMovies(this.cardAspectRatio, this.popular, this.genreList);
  @override
  Widget build(BuildContext context) {
    String genres = genreList.data.getGenre(popular.genreIds);

    return Column(
      children: [
        new Row(
          children: [
            Container(
                width: 185,
                height: 300,
                child: new ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      "http://image.tmdb.org/t/p/w342/${popular.posterPath}"),
                )),
            Container(
              width: MediaQuery.of(context).size.width - 20 - 185,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      popular.title,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 4.0, // gap between adjacent chips
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          '${popular.voteAverage}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                            '${getMonthString(formatDate(popular.releaseDate))} ${getDateNumSingle(formatDate(popular.releaseDate))}  ',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 5,
                        ),
                        dot(),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${getYear(formatDate(popular.releaseDate))}",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    new Text(
                      genres,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
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
