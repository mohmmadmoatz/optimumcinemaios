import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/api/download.dart';
import 'package:cinema_project/constant.dart/serverapi.dart';
import 'package:cinema_project/main.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/movie/list_of_movies.dart';
import 'package:cinema_project/ui/screens/sub/play.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cinema_project/ui/play.dart';
import 'package:toast/toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class Movie extends StatefulWidget {
  final Moviemodal moviemodal;

  const Movie({
    Key key,
    this.moviemodal,
  }) : super(key: key);

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> with AfterLayoutMixin {
  TextEditingController textEditingController = new TextEditingController();
  get title => null;
  bool isfav = false;

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                //  Get.to(VideoApp());
              },
              child: Container(
                height: 450,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.moviemodal.poster ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    Positioned.fill(
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                blurRadius: 100,
                                spreadRadius: 100,
                                offset: Offset(0, 40))
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    widget.moviemodal.name ?? '',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/imdb.png")),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      widget.moviemodal.rate.toString() ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .color),
                                    ),
                                  ],
                                ),
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
                          leading: IconButton(
                              icon: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back),
                              ),
                              onPressed: () => Get.back()),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            buildActions(),
            SizedBox(height: 5),
            if (!iphone) buildActions2(),
            SizedBox(height: 25),
            buildDetails(widget.moviemodal),
            SizedBox(height: 25),
            movierepo.raltedtomovielooding
                ? SpinKitCircle(
                    size: 30,
                    color: Colors.white,
                  )
                : ListOfMovies(
                    title: tr('recommended'), movies: movierepo.raltedtomovie),
            if (iphone)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "ادخل تعليقك",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RotatedBox(
                            quarterTurns: 2,
                            child: InkWell(
                              onTap: () async {
                                await movierepo.svaecomment(
                                    widget.moviemodal.id.toString(),
                                    textEditingController.text);
                                textEditingController.text = '';
                                setState(() {});
                              },
                              child: Icon(
                                Icons.send_outlined,
                                size: 28,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'التعليقات :',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    for (var i = 0; i < movierepo.comments.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  i.toString() + "-" ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  movierepo.comments[i] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildActions2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return new AlertDialog(
                        backgroundColor: Colors.transparent,
                        title: Text(""),
                        content: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height * 0.3,
                            // width: MediaQuery.of(context).size.width * 0.5,
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(
                                      widget.moviemodal.trailer)),
                              showVideoProgressIndicator: true,
                            ),
                          ),
                        ),
                      );
                    });
              },
              color: Theme.of(context).accentColor.withOpacity(0.75),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.play, size: 18),
                      SizedBox(width: 5),
                      Text('اعلان',
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
      ),
    );
  }

  Widget buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                http.get(Uri.parse(
                    server + "/api/viewcountermovie/" + widget.moviemodal.id));
                //for iphone
                if (iphone) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            height: 330,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Rate",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                buildDetails(widget.moviemodal),
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
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      onPressed: () {
                                        Toast.show(
                                            "Thanks for Rating", context);
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
                      });
                } else {
                  var content = '';
                  if (widget.moviemodal.vvt != '') {
                    content = await linkTosrt(widget.moviemodal.vvt);
                  }
                  print("con:$content");

                  Get.to(Playvideo(
                    moviemodal: widget.moviemodal,
                    videoUrl: widget.moviemodal.url,
                    vvt: widget.moviemodal.vvt,
                    content: content,
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
                        Text(tr('Rate', args: ['']),
                            style: TextStyle(
                                height: 2.2,
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      if (!iphone)
                        Text(tr('play', args: ['']),
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
          if (iphone)
            Expanded(
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
                  onPressed: () {
                    Provider.of<MovieRepo>(context, listen: false)
                        .addtochannelsfav(
                      widget.moviemodal,
                      context,
                    );
                    setState(() {
                      isfav = !isfav;
                    });
                  },
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                              isfav
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 18),
                          SizedBox(width: 5),
                          Text(tr('المفضلة'),
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
          if (!iphone)
            Expanded(
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
                  onPressed: () {
                    Provider.of<DownloadApi>(context, listen: false)
                        .queueDownload(
                      name: widget.moviemodal.name,
                      url: widget.moviemodal.url,
                    );
                  },
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
        })
        .replaceAllMapped(
            new RegExp(r'(\d+):(\d+)\.(\d+)\s*--?>\s*(\d+):(\d+):(\d+)\.(\d+)'),
            (Match m) =>
                '${'00:' + m[1] + ':' + m[2] + ',' + m[3] + ' --> ' + '0' + m[4] + ':' + m[5] + ':' + m[6] + ',' + m[7]}')
        .replaceAll(new RegExp('WEBVTT[\n|\r]+'), '');
    return ss;
  }

  Container buildDetails(Moviemodal moviemodal) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildRecord(title: tr('releaseDate'), value: moviemodal.year),
          SizedBox(height: 10),

          buildRecord(title: 'المخرج', value: moviemodal.director),
          SizedBox(height: 10),

          //buildRecord(title: 'الممثلين', value: moviemodal.actors),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الممثلين :',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
              SizedBox(width: 5),
              Text(
                moviemodal.actors ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: Theme.of(context)
                        .textTheme
                        .headline1
                        .color
                        .withOpacity(0.5)),
              ),
            ],
          ),
          //  buildRecord(title: tr('director'), value: 'Harry Bradbeer'),
          //  buildRecord(
          //       title: tr('cast'), value: 'Millie Bobby Brown,moviemodal'),
          //   SizedBox(height: 30),
          SizedBox(height: 10),

          Text(
            tr('description'),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
          ),
          SizedBox(height: 10),
          Text(
            // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',

            moviemodal.desc,
            style: TextStyle(
                fontSize: 12.5,
                color: Theme.of(context)
                    .textTheme
                    .headline1
                    .color
                    .withOpacity(0.7)),
          )
        ]),
      ),
    );
  }

  Row buildRecord({String title, String value, bool bright = false}) {
    return Row(
      children: [
        Text(
          title ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
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
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    Provider.of<MovieRepo>(context, listen: false)
        .getrelatedtomovie(context: context, id: widget.moviemodal.id);
    if (iphone) {
      Provider.of<MovieRepo>(context, listen: false)
          .getcomments(widget.moviemodal.id.toString());
    }
  }
}
