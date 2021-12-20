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

class SeeMore extends StatefulWidget {
  final bool isMovies;
  final String type;

  const SeeMore({Key key, this.isMovies = true, this.type}) : super(key: key);

  @override
  _SeeMoreState createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> with AfterLayoutMixin {
  RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  int _page = 1;
  List<Moviemodal> movies = [];
  List<SeriseModal> seriess = [];

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context);
    if (widget.isMovies) {
      if (widget.type == "box office") {
        movies = movierepo.boxofficecat;
      }
      if (widget.type == "recently add") {
        movies = movierepo.recentlyaddedcat;
      } else if (widget.type == "Top new") {
        movies = movierepo.exclusivecat;
      }
    } else {
      seriess = movierepo.recentlyaddedcatserise;
    }

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
      body: Column(
        children: [
          Expanded(
            child: SmartRefresher(
                header: MaterialClassicHeader(
                  color: Colors.white,
                  backgroundColor: Colors.redAccent,
                ),
                enablePullDown: true,
                enablePullUp: movierepo.hasmore,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                footer: ClassicFooter(
                  idleText: "اسحب",
                  loadingText: "تحميل المزيد",
                  outerBuilder: (wed) => Container(
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "يرجى الأنتضار",
                            //   textDirection: TextDirection.rtl,
                          ),
                        ),
                        SpinKitCircle(size: 30, color: Colors.white),
                      ],
                    )),
                  ),
                ),
                child: widget.isMovies
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 11 / 16),
                        itemCount: movies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration:
                                Duration(milliseconds: _page > 1 ? 20 : 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MovieWidget(
                                    moviemodal: movies[index],
                                    radius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 10 / 9,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 30),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: seriess.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration:
                                Duration(milliseconds: _page > 1 ? 20 : 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SeriesWidget(
                                    seriseModal: seriess[index],
                                    // BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
          )
        ],
      ),
    );
  }

  _onLoading() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = _page + 1;

    if (widget.type == "box office") {
      await movierepo.getboxoffice(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == "recently add") {
      await movierepo.getrecentlyadded(
          context: context, page: _page, fitstrequst: false);
    } else if (widget.type == "Top new") {
      await movierepo.getexclusive(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeForthSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeSecondSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  _onRefresh() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = 1;

    movierepo.boxoffice.clear();

    movierepo.hasmore = true;

    if (widget.type == "box office") {
      await movierepo.getboxoffice(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == "recently add") {
      await movierepo.getrecentlyadded(
          context: context, page: _page, fitstrequst: false);
    } else if (widget.type == "Top new") {
      await movierepo.getexclusive(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeForthSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeSecondSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
    //prdlist = products.prdlist;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    // widget.onRefresh();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // TODO: implement afterFirstLayout
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = 1;

    movierepo.hasmore = true;

    if (widget.type == "box office") {
      await movierepo.getboxoffice(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == "recently add") {
      await movierepo.getrecentlyadded(
          context: context, page: _page, fitstrequst: false);
    } else if (widget.type == "Top new") {
      await movierepo.getexclusive(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeForthSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
    if (widget.type == tr('homeSecondSection')) {
      await movierepo.getrecentlyaddedserise(
          context: context, page: _page, fitstrequst: false);
    }
  }
}
