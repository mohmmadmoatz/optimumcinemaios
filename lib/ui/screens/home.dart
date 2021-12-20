import 'package:after_layout/after_layout.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/constant.dart/shimmerloding.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/carousel_slider.dart';
import 'package:cinema_project/ui/components/widgets/movie/list_of_movies.dart';
import 'package:cinema_project/ui/components/widgets/series/list_of_series.dart';
import 'package:cinema_project/ui/components/widgets/trailer/list_of_trailers.dart';
import 'package:cinema_project/ui/screens/sub/see_more.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cinema_project/main.dart';

class Home extends StatefulWidget {
  final drawerFunction;

  const Home({Key key, this.drawerFunction}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin {
  PageController pageController = PageController();
  bool loding = true;
  int i = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (i == 8) {
      return;
    }
    if (i < 5) {
      i++;
    } else {
      i++;
      setState(() {
        loding = false;
      });
    }

    print("objjjjject");
  }

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            loding
                ? Container(
                    height: MediaQuery.of(context).size.height * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitCircle(
                          color: Colors.white,
                          size: 30,
                        ),
                        Text("Loading data please wait")
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      CarouselSlider(
                        image: movierepo.sliderimg ?? [],
                        carouselController: pageController,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 20,
                                  spreadRadius: 10)
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          AppBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            leading: IconButton(
                              icon: Icon(FeatherIcons.menu),
                              onPressed: () => widget.drawerFunction(),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
            //      SizedBox(height: 35),
            loding && iphone
                ? LodingMovies(
                    hight: 250,
                    widthh: 9 / 16,
                  )
                : ListOfMovies(
                    title: tr('next shows'),
                    buttonText: tr('more'),
                    buttonFunction: () => Get.to(SeeMore(
                          type: "recently add",
                        )),
                    movies: movierepo.recentlyadded),
            SizedBox(height: 35),

            loding
                ? LodingMovies(
                    hight: 250,
                    widthh: 9 / 16,
                  )
                : ListOfMovies(
                    title: tr('احدث الافلام'),
                    buttonText: tr('more'),
                    buttonFunction: () => Get.to(SeeMore(
                          type: "recently add",
                        )),
                    movies: movierepo.recentlyadded),
            SizedBox(height: 35),
            loding
                ? LodingMovies(
                    hight: 150,
                    widthh: 13 / 8,
                  )
                : ListOfSeries(
                    title: tr('احدث المسلسلات'),
                    buttonText: tr('more'),
                    buttonFunction: () => Get.to(SeeMore(
                          isMovies: false,
                          type: tr('homeForthSection'),
                        )),
                    series: movierepo.recentlyaddedcatserise),
            SizedBox(height: 35),

            loding
                ? LodingMovies(
                    hight: 250,
                    widthh: 9 / 16,
                  )
                : ListOfMovies(
                    title: tr('homeFirstSection'),
                    buttonText: tr('more'),
                    buttonFunction: () => Get.to(SeeMore(
                          type: "box office",
                        )),
                    movies: movierepo.boxoffice),
            SizedBox(height: 35),
            loding
                ? LodingMovies(
                    hight: 150,
                    widthh: 13 / 8,
                  )
                : ListOfSeries(
                    title: tr('homeSecondSection'),
                    buttonText: tr('more'),
                    buttonFunction: () => Get.to(SeeMore(
                        type: tr('homeSecondSection'), isMovies: false)),
                    series: movierepo.recentlyaddedcatserise),

            SizedBox(height: 35),
            // loding
            //     ? LodingMovies(
            //         hight: 250,
            //         widthh: 9 / 16,
            //       )
            //     : ListOfMovies(
            //         title: tr('homeFifthSection'),
            //         buttonText: tr('more'),
            //         buttonFunction: () => Get.to(SeeMore(
            //               type: "Top new",
            //             )),
            //         movies: movierepo.exclusive),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }
}
