import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/movie/grid_of_movies.dart';
import 'package:cinema_project/ui/components/widgets/movie/list_of_movies.dart';
import 'package:cinema_project/ui/screens/sub/CollectionMovies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  int _page = 1;

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black12,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(tr('thirdPageTitle'),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            child: SmartRefresher(
                header: MaterialClassicHeader(
                  color: Colors.white,
                  backgroundColor: Colors.redAccent,
                ),
                enablePullDown: true,
                enablePullUp: movierepo.hasmoercollectionlist,
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
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: Provider.of<MovieRepo>(context, listen: false)
                        .collectionlist
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: Duration(milliseconds: _page > 1 ? 20 : 30),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListOfMovies(
                                  title: tr(Provider.of<MovieRepo>(context,
                                          listen: false)
                                      .collectionlist[index]
                                      .name),
                                  buttonText: tr('الكل'),
                                  buttonFunction: () {
                                    Get.to(CollectionlistMovies(
                                      collectionname: Provider.of<MovieRepo>(
                                              context,
                                              listen: false)
                                          .collectionlist[index]
                                          .name,
                                      movies: Provider.of<MovieRepo>(context,
                                              listen: false)
                                          .collectionlist[index]
                                          .movies,
                                    ));
                                  },
                                  movies: Provider.of<MovieRepo>(context,
                                          listen: false)
                                      .collectionlist[index]
                                      .movies),
                            ),
                          ),
                        ),
                      );
                    })),
          ),
        ]));
  }

  _onLoading() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = _page + 1;

    await movierepo.getcollectionlist(
        context: context, page: _page, fitstrequst: false);

    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  _onRefresh() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = 1;

    movierepo.collectionlist.clear();

    movierepo.hasmoercollectionlist = true;

    await movierepo.getcollectionlist(
        context: context, page: _page, fitstrequst: false);

    //prdlist = products.prdlist;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    // widget.onRefresh();
  }
}
