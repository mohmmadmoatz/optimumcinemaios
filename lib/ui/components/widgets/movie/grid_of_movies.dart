import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GridOfMovies extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<Moviemodal> movies;
  final int moviePerLine;
  final bool slide;

  const GridOfMovies(
      {Key key,
      this.title,
      this.buttonText,
      this.buttonFunction,
      @required this.movies,
      this.moviePerLine = 3,
      this.slide = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: moviePerLine,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15),
        padding: EdgeInsets.symmetric(horizontal: 20),
        //  shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 275),
            child: slide
                ? SlideAnimation(
                    horizontalOffset: 35.0,
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: MovieWidget(
                        moviemodal: movies[index],
                        radius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  )
                : FadeInAnimation(
                    duration: const Duration(milliseconds: 675),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Container(
                        child: MovieWidget(
                          moviemodal: movies[index],
                          radius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
