import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:after_layout/after_layout.dart';
import 'package:better_player/better_player.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math; // import this
import 'package:video_player/video_player.dart';
import 'package:video_viewer/video_viewer.dart';

class Playvideo extends StatefulWidget {
  final String videoUrl;
  final String vvt;
  final String content;
  final Moviemodal moviemodal;

  Playvideo({Key key, this.videoUrl, this.vvt, this.moviemodal, this.content})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<Playvideo> with AfterLayoutMixin {
  SharedPreferences prefs;
  int rotation = 0;
  Duration startfrom;
  bool isfowrword = false;
  bool isbackword = false;
  double voulm = 0;

  @override
  void dispose() {
    //_betterPlayerController.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  double _aspectRatio = 16 / 9;
  bool _isKeptOn = false;
  double _brightness = 1.0;

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  StreamController<bool> _playController = StreamController.broadcast();
  Widget _buildPlaceholder() {
    return StreamBuilder<bool>(
      stream: _playController.stream,
      builder: (context, snapshot) {
        bool showPlaceholder = snapshot.data ?? true;
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: showPlaceholder ? 1.0 : 0.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  BetterPlayerController _betterPlayerController;
  final VideoViewerController controller = VideoViewerController();
  @override
  void initState() {
    /*   print(widget.vvt);
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
        fontColor: Colors.white,
        outlineColor: Colors.black,
        fontSize: 20,
      ),
      controlsConfiguration: BetterPlayerControlsConfiguration(
          enableProgressBar: true,
          enableProgressText: true,
          playerTheme: BetterPlayerTheme.material),

      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      //  placeholder: _buildPlaceholder(),
      autoPlay: true,
    );

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);

    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        _playController.add(false);
      }
    });
    _setupDataSource();
    */ // subtitleController.subtitleUrl = widget.vvt;
    super.initState();
    controller.addListener(() {
      if (controller.isBuffering) {
        controller.openFullScreen();
      }
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void _setupDataSource() async {
    print(widget.vvt);
    //  var content = await linkTosrt(widget.vvt);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
      widget.videoUrl,
      notificationConfiguration: BetterPlayerNotificationConfiguration(
          showNotification: true,
          author: widget.moviemodal.director,
          imageUrl: widget.moviemodal.poster,
          title: widget.moviemodal.name),
      subtitles: widget.vvt != null
          ? BetterPlayerSubtitlesSource.single(
              type: BetterPlayerSubtitlesSourceType.memory,

              content: widget.content,
              //url: widget.vvt,
              name: "ترجمة عربي",
              selectedByDefault: true,
            )
          : null,
    );

    await _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.moviemodal.name),
        ),
        body: AspectRatio(
          aspectRatio: 16 / 9,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: VideoViewer(
              autoPlay: true,
              enableFullscreenScale: true,
              onFullscreenFixLandscape: true,
              language: VideoViewerLanguage.ar,
              enableVerticalSwapingGesture: false,
              controller: controller,
              style: VideoViewerStyle(
                  progressBarStyle: ProgressBarStyle(
                      fullScreenExit: InkWell(
                          onTap: () {
                            controller.closeFullScreen();
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                          },
                          child: Icon(Icons.fullscreen_exit))),
                  header: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Container(
                        child: Text(
                          widget.moviemodal.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
              source: {
                "movie": VideoSource(
                    video: VideoPlayerController.network(widget.videoUrl),
                    subtitle: {
                      "هربي": VideoViewerSubtitle.network(widget.vvt,
                          type: SubtitleType.webvtt)
                    })
              },
            ),
          ),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}

// Positioned(
//   left: 1,
//   child: Padding(
//     padding: const EdgeInsets.only(top: 10, bottom: 30),
//     child: RotatedBox(
//       quarterTurns: 1,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 2,
//         //     height: MediaQuery.of(context).size.height,
//         child: Slider(
//             activeColor: Colors.transparent,
//             inactiveColor: Colors.transparent,
//             value: _brightness,
//             onChanged: (double b) {
//               setState(() {
//                 _brightness = b;
//               });
//               Screen.setBrightness(b);
//             }),
//       ),
//     ),
//   ),
// ),
// Positioned(
//   right: 1,
//   child: Padding(
//     padding: const EdgeInsets.only(top: 10, bottom: 30),
//     child: RotatedBox(
//       quarterTurns: 1,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 2,
//         //     height: MediaQuery.of(context).size.height,
//         child: Slider(
//             activeColor: Colors.transparent,
//             inactiveColor: Colors.transparent,
//             value: voulm,
//             onChanged: (double b) {
//               setState(() {
//                 voulm = b;
//                 _chewieController.setVolume(b);
//               });
//             }),
//       ),
//     ),
//   ),
// ),
// Positioned(
//   top: MediaQuery.of(context).size.height / 2.5,
//   right: 50,
//   left: 50,
//   child: Container(
//       child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       InkWell(
//         onDoubleTap: () {
//           setState(() {
//             isfowrword = true;
//             _chewieController
//                 .seekTo(Duration(seconds: 15));
//             Timer(Duration(seconds: 3), (() {
//               setState(() {
//                 isfowrword = false;
//               });
//             }));
//           });
//         },
//         child: Container(
//           width: 200,
//           height: 100,
//           child: Align(
//             child: Icon(
//               Icons.forward_10_outlined,
//               size: 60,
//               color: isfowrword
//                   ? Colors.white
//                   : Colors.transparent,
//             ),
//           ),
//         ),
//       ),
//       InkWell(
//         onDoubleTap: () {
//           setState(() {
//             isbackword = true;
//             _chewieController
//                 .seekTo(Duration(seconds: 15));
//             Timer(Duration(seconds: 3), (() {
//               setState(() {
//                 isbackword = false;
//               });
//             }));
//           });
//         },
//         child: Container(
//           width: 200,
//           height: 100,
//           child: Align(
//             child: Icon(
//               Icons.settings_backup_restore_sharp,
//               size: 60,
//               color: isbackword
//                   ? Colors.white
//                   : Colors.transparent,
//             ),
//           ),
//         ),
//       )
//     ],
//   )),
// ),
