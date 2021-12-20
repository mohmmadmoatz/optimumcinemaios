import 'package:after_layout/after_layout.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/model/Catmodel.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/model/SeriseModal.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/movie/grid_of_movies.dart';
import 'package:cinema_project/ui/components/widgets/movie/movie_widget.dart';
import 'package:cinema_project/ui/components/widgets/series/grid_of_series.dart';
import 'package:cinema_project/ui/components/widgets/series/series_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Category extends StatefulWidget {
  final int initialIndex;
  final CatagoryModel catagoryModel;
  const Category({Key key, this.initialIndex = 0, this.catagoryModel})
      : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with TickerProviderStateMixin, AfterLayoutMixin {
  TabController _tabController;
  RefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = new TabController(
        length: 2, vsync: this, initialIndex: widget.initialIndex);
  }

  int _pageseries = 1;
  int _pagemovie = 1;
  List<Moviemodal> movies = [];
  List<SeriseModal> seriess = [];

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);
    movies = movierepo.langugecatagorymovies;

    seriess = movierepo.recentlyaddedcatserise;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.catagoryModel.name,
            style: TextStyle(
                fontWeight: FontWeight.w700, height: 2.2, fontSize: 22),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(top: 5, right: 18),
          //     child: Container(
          //       width: 120,
          //       child: DropdownSearch(
          //         items: movierepo.onlylang,

          //         //label: "اللغة",
          //         onChanged: (str) {
          //           print(str);
          //           if (str == null)
          //             return "Required field";
          //           else if (str == "عربي")
          //             return "Invalid item";
          //           else
          //             return null;
          //         },
          //         selectedItem: "الكل",
          //         // InputDecoration(hintStyle: TextStyle(fontSize: 10)),
          //         searchBoxDecoration:
          //             InputDecoration(hintStyle: TextStyle(fontSize: 10)),
          //       ),
          //     ),
          //   ),
          // ],
          bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              labelStyle: TextStyle(
                  height: 2.2,
                  fontSize: 15,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                  fontWeight: FontWeight.w700),
              indicator: BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Theme.of(context).indicatorColor,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: [Text('Movies').tr(), Text('Series').tr()]),
        ),
        body: TabBarView(controller: _tabController, children: <Widget>[
          Column(
            children: [
              SizedBox(height: 10),
              Expanded(
                child: SmartRefresher(
                  header: MaterialClassicHeader(
                    color: Colors.white,
                    backgroundColor: Colors.redAccent,
                  ),
                  enablePullDown: true,
                  enablePullUp: movierepo.hasmorecatmovie,
                  controller: _refreshController,
                  onRefresh: _onRefreshmovie,
                  onLoading: _onLoadingmovie,
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
                  child: movierepo.lodingcatagorymovies
                      ? SpinKitCircle(size: 30, color: Colors.white)
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 9 / 16,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15),
                          itemCount: movierepo.langugecatagorymovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: Duration(
                                    milliseconds: _pagemovie > 1 ? 20 : 375),
                                columnCount: 2,
                                child: SlideAnimation(
                                  horizontalOffset: 35.0,
                                  child: AspectRatio(
                                    aspectRatio: 9 / 16,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MovieWidget(
                                        moviemodal: movierepo
                                            .langugecatagorymovies[index],
                                        radius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                ),
              )
            ],
          ),
          serieswidget(movierepo)
        ]));
  }

  Widget serieswidget(MovieRepo movieRepo) {
    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: SmartRefresher(
            header: MaterialClassicHeader(
              color: Colors.white,
              backgroundColor: Colors.redAccent,
            ),
            enablePullDown: true,
            enablePullUp: movieRepo.hasmorecatseries,
            controller: _refreshController,
            onRefresh: _onRefreshseries,
            onLoading: _onLoadingseries,
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
            child: movieRepo.loadingcatagoryseries
                ? SpinKitCircle(size: 30, color: Colors.white)
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 10 / 9,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: movieRepo.catagoryseries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration:
                              Duration(milliseconds: _pagemovie > 1 ? 20 : 375),
                          columnCount: 2,
                          child: SlideAnimation(
                            horizontalOffset: 35.0,
                            child: AspectRatio(
                              aspectRatio: 9 / 16,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SeriesWidget(
                                  seriseModal: movieRepo.catagoryseries[index],
                                ),
                              ),
                            ),
                          ));
                    }),
          ),
        )
      ],
    );
  }

  _onLoadingseries() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _pageseries = _pageseries + 1;

    Provider.of<MovieRepo>(context, listen: false).getseriescatagory(
      context: context,
      catid: widget.catagoryModel.id,
      page: _pageseries,
    );

    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  _onLoadingmovie() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _pagemovie = _pagemovie + 1;
    Provider.of<MovieRepo>(context, listen: false).getcatagorymovies(
        context: context,
        id: widget.catagoryModel.id,
        page: _pagemovie,
        langid: 0);

    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  _onRefreshmovie() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _pagemovie = 1;

    movierepo.catagoryseries.clear();

    movierepo.hasmorecatseries = true;
    Provider.of<MovieRepo>(context, listen: false).getcatagorymovies(
        context: context,
        id: widget.catagoryModel.id,
        page: _pagemovie,
        langid: 0);

    //prdlist = products.prdlist;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    // widget.onRefresh();
  }

  _onRefreshseries() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _pageseries = 1;

    movierepo.catagoryseries.clear();

    movierepo.hasmorecatseries = true;

    Provider.of<MovieRepo>(context, listen: false).getseriescatagory(
      context: context,
      catid: widget.catagoryModel.id,
      page: _pageseries,
    );

    //prdlist = products.prdlist;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    // widget.onRefresh();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    Provider.of<MovieRepo>(context, listen: false).getcatagorymovies(
        context: context, id: widget.catagoryModel.id, page: 1, langid: 0);
    Provider.of<MovieRepo>(context, listen: false).getseriescatagory(
      context: context,
      catid: widget.catagoryModel.id,
      page: 1,
    );
  }
}
