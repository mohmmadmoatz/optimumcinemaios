import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/ui/screens/sub/play.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import 'package:cinema_project/api/MovieRepo.dart';

class EpisodeWidget extends StatelessWidget {
  final String title;
  final String vtt;
  final String image;
  final int season;
  final String url;
  final String number;
  final bool seen;

  const EpisodeWidget(
      {Key key,
      this.title,
      this.image,
      this.season = 1,
      this.number,
      this.seen = false,
      this.url,
      this.vtt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        return Provider.of<MovieRepo>(context, listen: false)
            .changeepsodechoose(title, url, vtt);
      },
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl: image,
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.22),
                                  BlendMode.darken),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Theme.of(context)
                              .textTheme
                              .headline1
                              .color
                              .withOpacity(0.2),
                          highlightColor: Theme.of(context)
                              .textTheme
                              .headline1
                              .color
                              .withOpacity(0.35),
                          child: Container(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              number.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color),
                            ),
                            SizedBox(height: 10),
                            Text(
                              title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (seen == true)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor.withOpacity(.75),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    FeatherIcons.checkCircle,
                    color: Theme.of(context).textTheme.headline1.color,
                    size: 19,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
