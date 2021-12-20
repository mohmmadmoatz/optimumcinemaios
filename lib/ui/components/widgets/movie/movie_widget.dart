import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/screens/sub/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWidget extends StatelessWidget {
  final Moviemodal moviemodal;
  final BorderRadiusGeometry radius;

  const MovieWidget({
    Key key,
    this.radius,
    this.moviemodal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(moviemodal.trailer);
        showDialog(
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              title: Text(""),
              content: InkWell(
                onTap: () {
                  Get.to(Movie(
                    moviemodal: moviemodal,
                  ));
                },
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                        initialVideoId:
                            YoutubePlayer.convertUrlToId(moviemodal.trailer)),
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),
            );
          },
          context: context,
        );
      },
      onTap: () {
        Get.to(Movie(
          moviemodal: moviemodal,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: radius,
              child: CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                imageUrl: moviemodal.poster,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor:
                      Theme.of(context).primaryColor.withOpacity(0.4),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          if (moviemodal.name != null)
            Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 2),
                  child: Text(
                    moviemodal.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.headline1.color),
                  ),
                )),
          if (moviemodal.rate != null)
            Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 1, left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            child: Container(
                                width: 35,
                                child: Image.asset('assets/images/imdb.png')),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          SizedBox(width: 5),
                          Text(
                            moviemodal.rate.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .color
                                    .withOpacity(0.34)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FeatherIcons.eye,
                            size: 17,
                            color: Theme.of(context)
                                .textTheme
                                .headline1
                                .color
                                .withOpacity(0.7),
                          ),
                          SizedBox(width: 5),
                          Text(
                            moviemodal.views,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                height: 1.8,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .color
                                    .withOpacity(0.34)),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
