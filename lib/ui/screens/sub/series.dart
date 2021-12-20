import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/constant.dart/serverapi.dart';
import 'package:cinema_project/main.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/model/SeriseModal.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/theme.dart';
import 'package:cinema_project/ui/components/widgets/episode/list_of_episodes.dart';
import 'package:cinema_project/ui/components/widgets/series/list_of_series.dart';
import 'package:cinema_project/ui/play.dart';
import 'package:cinema_project/ui/screens/sub/play.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Series extends StatefulWidget {
  final int id;
  final String title;
  final int seasons;
  final int episodes;
  final String image;
  final SeriseModal seriseModal;

  const Series(
      {Key key,
      this.id,
      this.image,
      this.title,
      this.seasons,
      this.episodes,
      this.seriseModal})
      : super(key: key);

  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> with AfterLayoutMixin {
  String seasons = "";
  ScrollController episodesScroll = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.seriseModal.poster ?? '',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Theme.of(context).primaryColor),
                  ),
                  Positioned.fill(
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(1),
                              blurRadius: 40,
                              spreadRadius: 70,
                              offset: Offset(0, 40))
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title ?? '',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                              //    SizedBox(height: 15),
                              /*
                              Text(
                                tr('seasonsCount', args: ['${widget.seasons}']),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .color),
                              ),
                              Text(
                                tr('episodesCount',
                                    args: ['${widget.episodes}']),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .color),
                              ),
                              */
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      )
                    ],
                  )
                ],
              ),
            ),

            buildRecord(
                title: tr('المخرج'), value: widget.seriseModal.director),
            buildRecord(
                title: tr('releaseDate'), value: widget.seriseModal.year),
            buildRecord(
                title: tr('التقييم:'), value: widget.seriseModal.seriesRate),
            //  buildRecord(
            //        title: tr('cast'),
            //      value: 'Millie Bobby Brown, Louis Partridge, Henry Cavill'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "الممثلين" ?? '',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 250,
                      child: Text(
                        widget.seriseModal.actor ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: Theme.of(context)
                                .textTheme
                                .headline1
                                .color
                                .withOpacity(0.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            buildActions(seasons, movierepo),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  height: 40,
                  child: movierepo.lodingsesoms
                      ? SpinKitCircle(
                          color: mainColor,
                          size: 30,
                        )
                      : buildseosons(movierepo)),
            ),
            SizedBox(height: 30),

            buildDetails(movierepo),
            SizedBox(height: 30),
            //    ListOfSeries(title: tr('recommended'), series: null),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildDetails(MovieRepo movieRepo) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              tr('episodesList'),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
          ),
          movieRepo.seriesseonsepsiodsloding
              ? SpinKitCircle(
                  size: 30,
                  color: mainColor,
                )
              : ListOfEpisodes(
                  seriess: movieRepo.seriesseonsepsods,
                  scrollController: episodesScroll,
                  image: widget.seriseModal.poster,
                ),
        ],
      ),
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('description'),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            SizedBox(height: 5),
            Text(
              //'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              widget.seriseModal.seriesDesc ?? "",
              style: TextStyle(
                  fontSize: 12.5,
                  color: Theme.of(context)
                      .textTheme
                      .headline1
                      .color
                      .withOpacity(0.7)),
            )
          ],
        ),
      ),
    ]);
  }

  Widget buildRecord({String title, String value, bool bright = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Row(
          children: [
            Text(
              title ?? '',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 5),
            Text(
              value ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                  color: bright
                      ? Theme.of(context).textTheme.headline1.color
                      : Theme.of(context)
                          .textTheme
                          .headline1
                          .color
                          .withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildseosons(MovieRepo movieRepo) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (var i = 0; i < movieRepo.sesons.length; i++)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                movieRepo.chooseseson(context, i);
                setState(() {
                  seasons = (i + 1).toString();
                  print("aaa" + seasons + movieRepo.epsodchoose);
                });
              },
              color: movieRepo.sesons[i]["ischecked"]
                  ? Theme.of(context).accentColor.withOpacity(0.75)
                  : Colors.transparent,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("season",
                          style: TextStyle(
                              height: 2.2,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      Text(movieRepo.sesons[i]["name"],
                          style: TextStyle(
                              height: 2.2,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                    ],
                  )),
            ),
          ),
      ],
    );
  }

  Widget buildActions(season, MovieRepo movieRepo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                if (iphone)
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          height: 380,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Rate",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              buildDetails(movieRepo),
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 30,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Center(
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => null,
                                  child: FlatButton(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                .color
                                                .withOpacity(0.3),
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(7)),
                                    onPressed: () {
                                      Toast.show("Thanks for Rating", context);
                                      Navigator.of(context).pop();
                                      // Provider.of<DownloadApi>(context, listen: false)
                                      //     .queueDownload(
                                      //   name: widget.moviemodal.name,
                                      //   url: widget.moviemodal.url,
                                      // );
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(FeatherIcons.star, size: 18),
                                            SizedBox(width: 5),
                                            Text(tr('Rate'),
                                                style: TextStyle(
                                                    height: 2.2,
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(width: 5),
                                          ],
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );

                if (movieRepo.epsodchoose == '' && !iphone) {
                  Toast.show("اختر حلقة اولا", context);
                  return;
                }
                var content = '';
                if (movieRepo.seriesvvt != '' && !iphone) {
                  print(movieRepo.seriesvvt + "xxx");
                  content = await linkTosrt(movieRepo.seriesvvt);
                }
                if (!iphone) {
                  Get.to(Playvideo(
                    videoUrl: movieRepo.seriesurl,
                    content: content,
                    vvt: movieRepo.seriesvvt,
                    moviemodal: Moviemodal(
                        director: widget.seriseModal.director,
                        name: widget.seriseModal.name,
                        poster: widget.seriseModal.poster),
                    // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                  ));
                }
              },
              color: Theme.of(context).accentColor.withOpacity(0.75),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.play, size: 18),
                      SizedBox(width: 5),
                      if (iphone)
                        Text(
                            tr('Rate', args: [
                              "S" + seasons + "-E" + movieRepo.epsodchoose,
                            ]),
                            style: TextStyle(
                                height: 2.2,
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      if (!iphone)
                        Text(
                            tr('play', args: [
                              "S" + seasons + "-E" + movieRepo.epsodchoose,
                            ]),
                            style: TextStyle(
                                height: 2.2,
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                    ],
                  )),
            ),
          ),
          SizedBox(width: 20),
          if (iphone == false)
            Expanded(
              flex: 4,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Get.to(Play()),
                child: FlatButton(
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context)
                              .textTheme
                              .headline1
                              .color
                              .withOpacity(0.3),
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(7)),
                  onPressed: () {},
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FeatherIcons.download, size: 18),
                          SizedBox(width: 5),
                          Text(tr('download'),
                              style: TextStyle(
                                  height: 2.2,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                        ],
                      )),
                ),
              ),
            ),
        ],
      ),
    );
  }

  linkTosrt(String link) async {
    http.Response data = await http.get(Uri.parse(link), headers: {
      "Content-Type": "text/html charset=utf-8",
    });
    String body = utf8.decode(data.bodyBytes);

    return toSrtRule(body);
  }

  String toSrtRule(String data) {
    int id = 0;
    var ss = data
        .replaceAll("&gt;&gt;", ">>")
        .replaceAllMapped(
            new RegExp(r'(\d+):(\d+)\.(\d+)\s*--?>\s*(\d+):(\d+)\.(\d+)'),
            (Match m) =>
                '${'00:' + m[1] + ':' + m[2] + ',' + m[3] + ' --> ' + '00:' + m[4] + ':' + m[5] + ',' + m[6]}')
        .replaceAllMapped(
            new RegExp(
                r'(\d+):(\d+):(\d+)(?:.(\d+))?\s*--?>\s*(\d+):(\d+):(\d+)(?:.(\d+))?',
                caseSensitive: false),
            (Match m) =>
                m[1] +
                ":" +
                m[2] +
                ":" +
                m[3] +
                "," +
                m[4] +
                " --> " +
                m[5] +
                ":" +
                m[6] +
                ":" +
                m[7] +
                "," +
                m[8])
        //srt 标准时间前一行需要id数字，所以根据判断，vtt文件没有的话就加上~
        .replaceAllMapped(new RegExp(r'(\d+)?([\n|\r]+)(\d+):(\d+)'),
            (Match m) {
      return m[1] == null
          ? '${m[2] + (++id).toString() + '\n' + m[3] + ':' + m[4]}'
          : '${m[0]}';
    }).replaceAll(new RegExp('WEBVTT[\n|\r]+'), '');

    return ss;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    var movierepo = Provider.of<MovieRepo>(context, listen: false);
    movierepo.getsesons(context, widget.seriseModal.id);
  }
}
