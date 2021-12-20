import 'dart:isolate';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/api/download.dart';
import 'package:cinema_project/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class Spachscreen extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Spachscreen> with AfterLayoutMixin {
  intiolaize() async {
    await FlutterDownloader.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    intiolaize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: App(),
      title: new Text(
        'اهلا بك في تطبيق فلمي',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image(
        image: AssetImage("assets/images/cinema.png"),
        width: 200,
        height: 200,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      loaderColor: Theme.of(context).accentColor,
      photoSize: 100,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<MovieRepo>(context, listen: false).chekping();
  }
}
