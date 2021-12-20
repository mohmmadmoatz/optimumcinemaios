import 'package:after_layout/after_layout.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/movie/grid_of_movies.dart';
import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:cinema_project/ui/components/widgets/series/grid_of_series.dart';
import 'package:cinema_project/ui/components/widgets/series/series_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cinema_project/model/SeriseModal.dart';

class FavOfMovies extends StatefulWidget {
  final bool isMovies;
  final String type;
  final List<Moviemodal> moviess;

  const FavOfMovies({Key key, this.isMovies = true, this.type, this.moviess})
      : super(key: key);

  @override
  _FavOfMoviesState createState() => _FavOfMoviesState();
}

class _FavOfMoviesState extends State<FavOfMovies> with AfterLayoutMixin {
  RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    movies.addAll(widget.moviess);
  }

  int _page = 1;
  List<Moviemodal> movies = [];
  List<SeriseModal> seriess = [];

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.type ?? "",
          style:
              TextStyle(fontWeight: FontWeight.w700, height: 2.2, fontSize: 22),
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 11 / 16),
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: Duration(milliseconds: _page > 1 ? 20 : 375),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MovieWidget(
                      moviemodal: movies[index],
                      radius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // TODO: implement afterFirstLayout
  }
}
