import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CollectionlistMovies extends StatefulWidget {
  final List<Moviemodal> movies;
  final String collectionname;

  const CollectionlistMovies({Key key, this.movies, this.collectionname})
      : super(key: key);

  @override
  _CollectionlistMoviesState createState() => _CollectionlistMoviesState();
}

class _CollectionlistMoviesState extends State<CollectionlistMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.collectionname,
            style: TextStyle(
                fontWeight: FontWeight.w700, height: 2.2, fontSize: 22),
          ),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 11 / 16),
            itemCount: widget.movies.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 20),
                columnCount: 2,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieWidget(
                        moviemodal: widget.movies[index],
                        radius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
