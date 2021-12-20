import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/search/search_bar.dart';
import 'package:cinema_project/ui/components/widgets/search/search_result.dart';
import 'package:cinema_project/ui/components/widgets/search/searchserise.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  TabController _tabController;
  TextEditingController searchController = new TextEditingController();
  RefreshController _refreshController;
  int _page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          shadowColor: Colors.black12,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Hero(
            tag: 'searchBar',
            child: SearchBar(
              searchController: searchController,
              preview: false,
            ),
          ),
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
          movierepo.lodingsearch
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: Theme.of(context).indicatorColor,
                      size: 40,
                    ),
                    Text("searching please wait")
                  ],
                )
              : SmartRefresher(
                  header: MaterialClassicHeader(
                    color: Colors.white,
                    backgroundColor: Colors.redAccent,
                  ),
                  enablePullDown: true,
                  enablePullUp: movierepo.hasmoresearch,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          tr('searchResults',
                              args: ['${movierepo.loademoremovies.length}']),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              height: 2.2,
                              color:
                                  Theme.of(context).textTheme.headline1.color),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: movierepo.loademoremovies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: SearchResult(
                                  moviemodal: movierepo.loademoremovies[index],
                                ));
                          },
                        ),
                      ),
                    ],
                  )),
          movierepo.lodingsearch
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      color: Theme.of(context).indicatorColor,
                      size: 40,
                    ),
                    Text("searching please wait")
                  ],
                )
              : SmartRefresher(
                  header: MaterialClassicHeader(
                    color: Colors.white,
                    backgroundColor: Colors.redAccent,
                  ),
                  enablePullDown: true,
                  enablePullUp: movierepo.hasmoresearch,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          tr('searchResults',
                              args: ['${movierepo.searchseaise.length}']),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              height: 2.2,
                              color:
                                  Theme.of(context).textTheme.headline1.color),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: movierepo.searchseaise.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: SearchResultsSeries(
                                  seriseModal: movierepo.searchseaise[index],
                                ));
                          },
                        ),
                      ),
                    ],
                  )),
        ]));
  }

  _onLoading() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = _page + 1;

    movierepo.getmoredata(_page);

    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  _onRefresh() async {
    final movierepo = Provider.of<MovieRepo>(context, listen: false);
    _page = 1;

    movierepo.loademoremovies.clear();
    movierepo.searchseaise.clear();

    movierepo.hasmoresearch = true;
    movierepo.search(searchController.text);

    //prdlist = products.prdlist;
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();

    // widget.onRefresh();
  }
}
