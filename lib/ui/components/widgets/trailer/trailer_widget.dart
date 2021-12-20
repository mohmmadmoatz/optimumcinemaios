import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/ui/screens/sub/play.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TrailerWidget extends StatelessWidget {
  final String title;
  final String image;
  final int navId;

  TrailerWidget({
    Key key,
    this.title = "",
    this.image = "",
    @required this.navId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => Get.to(Play()),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Stack(
                children: [
                  CachedNetworkImage(
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
                              Colors.black26, BlendMode.darken),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Theme.of(context).primaryColor,
                      highlightColor:
                          Theme.of(context).primaryColor.withOpacity(0.4),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      FeatherIcons.playCircle,
                      color: Theme.of(context).textTheme.headline1.color,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (title != null)
            Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 2),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.headline1.color),
                  ),
                )),
        ],
      ),
    );
  }
}
