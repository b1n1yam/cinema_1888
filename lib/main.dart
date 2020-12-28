import 'package:cinema_1888/pages/buy-ticket.dart';
import 'package:flutter/material.dart';

import 'package:cinema_1888/pages/home.dart';
import 'package:cinema_1888/pages/preloadContent.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:cinema_1888/repositories/cinema_api_impl.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton<CinemaAPI>(() => CinemaApiImplimentation());
}

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1888 Cinema',
      debugShowCheckedModeBanner: false,
      home: PreloadContent(),
    );
  }
}
