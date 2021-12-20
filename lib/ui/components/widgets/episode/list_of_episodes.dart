import 'package:cinema_project/model/SeriseModal.dart';
import 'package:cinema_project/ui/components/widgets/episode/episode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:cinema_project/api/MovieRepo.dart';

class ListOfEpisodes extends StatelessWidget {
  final List seriess;
  final String image;
  final ScrollController scrollController;

  const ListOfEpisodes(
      {Key key, this.scrollController, this.image, ollController, this.seriess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      child: AnimationLimiter(
        child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 12),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 5,
              );
            },
            shrinkWrap: true,
            itemCount: seriess.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  horizontalOffset: 70.0,
                  child: AspectRatio(
                    aspectRatio: 24 / 9,
                    child: InkWell(
                      onTap: () {},
                      child: EpisodeWidget(
                        image: image ?? "",
                        url: seriess[index]['url'],
                        vtt: seriess[index]['subtitle'],
                        title: seriess[index]['name'],
                        season: 0,
                        number: seriess[index]["name"],
                        seen: false,
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
