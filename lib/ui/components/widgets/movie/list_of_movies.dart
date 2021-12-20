import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:cinema_project/ui/components/widgets/widget_header.dart';
import 'package:cinema_project/ui/screens/sub/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListOfMovies extends StatelessWidget {
  final String title, buttonText;
  final Function buttonFunction;
  final List<Moviemodal> movies;

  const ListOfMovies(
      {Key key,
      @required this.title,
      this.buttonText,
      this.buttonFunction,
      @required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetHeader(
      title: title,
      button: InkWell(
          onTap: buttonFunction,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(buttonText ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              if (buttonText != null) Icon(FeatherIcons.chevronRight, size: 20),
            ],
          )),
      child: Container(
        height: 250,
        child: AnimationLimiter(
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 20,
                );
              },
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 675),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: MovieWidget(
                        moviemodal: movies[index],
                        radius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
