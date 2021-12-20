import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/ui/components/widgets/widget_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

class LodingMovies extends StatelessWidget {
  final double widthh;
  final double hight;
  const LodingMovies({Key key, this.widthh, this.hight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey,
        child: WidgetHeader(
            title: "جاري التحميل",
            button: InkWell(
                //    onTap: buttonFunction,
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            )),
            child: countinerr(context)));
  }

  Widget countinerr(context) {
    return Container(
      height: hight,
      child: AnimationLimiter(
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 20,
              );
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 675),
                child: SlideAnimation(
                  horizontalOffset: hight,
                  child: AspectRatio(
                    aspectRatio: widthh,
                    child: Container(
                      //    height: hight,
                      //      width: widthh,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
