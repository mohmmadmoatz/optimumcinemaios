import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:cinema_project/ui/components/widgets/series/series_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cinema_project/model/SeriseModal.dart';

class GridOfSeries extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<SeriseModal> series;
  final int seriesPerLine;
  final bool slide;

  const GridOfSeries(
      {Key key,
      this.title,
      this.buttonText,
      this.buttonFunction,
      @required this.series,
      this.seriesPerLine = 2,
      this.slide = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 10 / 9,
              crossAxisSpacing: 15,
              mainAxisSpacing: 30),
          padding: EdgeInsets.symmetric(horizontal: 20),
          //    shrinkWrap: true,
          itemCount: series.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 275),
              child: slide
                  ? SlideAnimation(
                      horizontalOffset: 35.0,
                      child: SeriesWidget(
                        seriseModal: series[index],
                        //    image: series[index]['image'],
                        //  title: series[index]['title'],
                        //seasons: series[index]['seasons'],
                        //episodes: series[index]['episodes'],
                      ),
                    )
                  : FadeInAnimation(
                      duration: const Duration(milliseconds: 675),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: SeriesWidget(
                          seriseModal: series[index],
                          //   image: series[index]['image'],
                          // title: series[index]['title'],
                          //rating: series[index]['rate'],
                          // radius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}
