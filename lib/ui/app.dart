import 'dart:isolate';
import 'dart:ui';
import 'package:cinema_project/main.dart';
import 'package:cinema_project/ui/components/widgets/movie/favmovies.dart';
import 'package:cinema_project/ui/screens/sub/About.dart';
import 'package:cinema_project/ui/screens/sub/Conditions.dart';
import 'package:cinema_project/ui/screens/sub/ContactUs.dart';
import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/api/download.dart';
import 'package:cinema_project/ui/downloads.dart';
import 'package:cinema_project/ui/screens/discover.dart';
import 'package:cinema_project/ui/screens/downloads.dart';
import 'package:cinema_project/ui/screens/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> with AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentTab;

  Widget home;
  Widget discover;
  Widget downloads;
  int progress = 0;
  var status = 0;
  ReceivePort _receivePort = ReceivePort();
  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    //  intiolaize();

    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      print("message:$message");
      progress = message[2];
      //status = message[1];
      Provider.of<DownloadApi>(context, listen: false)
          .incrementProgress(progress);

      print("progress:$progress");
    });

    FlutterDownloader.registerCallback(downloadingCallback);

    home = Home(drawerFunction: openTheDrawer);
    discover = Discover();
    downloads = Downloads();
    currentTab = 0;
    super.initState();
  }

  intiolaize() async {
    await FlutterDownloader.initialize();
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  void didChangeDependencies() {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      statusBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(context),
        body: IndexedStack(
          index: currentTab,
          children: _pages(),
        ),
        bottomNavigationBar: _buildNavigationBar(),
      ),
    );
  }

  List<Widget> _pages() {
    return <Widget>[
      stackedPage(0, home),
      stackedPage(1, discover),
      stackedPage(2, downloads),
    ];
  }

  Offstage stackedPage(int index, child) {
    return Offstage(
        offstage: currentTab != index,
        child: TickerMode(enabled: currentTab == index, child: child));
  }

  _buildNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      // showUnselectedLabels: false,
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor:
          Theme.of(context).textTheme.headline1.color.withOpacity(0.42),
      selectedItemColor: Theme.of(context).accentColor.withOpacity(0.81),
      selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, height: 2),
      unselectedLabelStyle:
          TextStyle(fontWeight: FontWeight.w700, fontSize: 11.5),
      elevation: 35.0,
      onTap: (int index) async {
        //This is for test
        if (index == 2) {
          if (Provider.of<MovieRepo>(context, listen: false)
                  .collectionlist
                  .length ==
              0) {
            await Provider.of<MovieRepo>(context, listen: false)
                .getcollectionlist(
                    context: context, fitstrequst: true, page: 1);
          }
        }
        setState(() {
          print(index);
          currentTab = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home), label: tr('firstPageTitle')),
        BottomNavigationBarItem(
            icon: Icon(FeatherIcons.search), label: tr('secondPageTitle')),
        BottomNavigationBarItem(
            icon: Icon(FeatherIcons.download), label: tr('thirdPageTitle')),
      ],
    );
  }

  ///Components
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 60,
                        ),
                        SizedBox(height: 10),
                        Text('فلمي',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                'https://images.unsplash.com/photo-1582648871034-149d26d4aad5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80'))),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(FeatherIcons.settings, size: 20),
                        SizedBox(width: 10),
                        Text('translate',
                                style: TextStyle(fontSize: 17, height: 2.2))
                            .tr(),
                      ],
                    ),
                    onTap: () {
                      EasyLocalization.of(context).locale == Locale('ar', 'IQ')
                          ? context.locale = Locale('en', 'US')
                          : context.locale = Locale('ar', 'IQ');
                    },
                  ),
                  if (!iphone) Divider(),
                  if (!iphone)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(FeatherIcons.share2, size: 20),
                          SizedBox(width: 10),
                          Text('connect',
                                  style: TextStyle(fontSize: 17, height: 2.2))
                              .tr(),
                        ],
                      ),
                      onTap: () {
                        Get.to(Connectwithus());
                      },
                    ),
                  if (iphone) Divider(),
                  if (iphone)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(FeatherIcons.share2, size: 20),
                          SizedBox(width: 10),
                          Text('Favorate Movies',
                                  style: TextStyle(fontSize: 17, height: 2.2))
                              .tr(),
                        ],
                      ),
                      onTap: () {
                        Get.to(FavOfMovies(
                          moviess:
                              Provider.of<MovieRepo>(context, listen: false)
                                  .faveroite,
                          type: "Favorate Movies",
                        ));
                      },
                    ),
                  Divider(),
                  if (!iphone)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(FeatherIcons.share2, size: 20),
                          SizedBox(width: 10),
                          Text('التحميلات',
                                  style: TextStyle(fontSize: 17, height: 2.2))
                              .tr(),
                        ],
                      ),
                      onTap: () {
                        Get.to(DownloadsVideos());
                      },
                    ),
                  if (!iphone)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(FeatherIcons.paperclip, size: 20),
                          SizedBox(width: 10),
                          Text('terms',
                                  style: TextStyle(fontSize: 17, height: 2.2))
                              .tr(),
                        ],
                      ),
                      onTap: () {
                        Get.to(Condtions(
                          texxt: [
                            "يجب ان يكون  مستخدم التطبيق من ضمن مستخدمين شركة اوبتيمم لاين حصرا",
                            "يجب ان يكون اشتراك المستخدم فعال للحصول على خدمة فلمي",
                            "في حال حدوث اي مشكلة يرجى ابلاغ شركة اوبتيمم لاين عن طريق الارقام الموجدة في خانة تواصل معنا"
                          ],
                        ));
                      },
                    ),
                  if (!iphone)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(FeatherIcons.info, size: 20),
                          SizedBox(width: 10),
                          Text('about',
                                  style: TextStyle(fontSize: 17, height: 2.2))
                              .tr(),
                        ],
                      ),
                      onTap: () {
                        Get.to(About(
                          texxt:
                              "تطبيق مخصص لمشتركي شركة اوبتميم  من اجل الاستمتاع بمشاهدة احدث الافلام",
                        ));
                      },
                    ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(50),
                child: Text(tr('version', args: ['1.0.0']),
                    style: TextStyle(fontSize: 17, color: Colors.grey)))
          ],
        ),
      ),
    );
  }

  openTheDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // TODO: implement afterFirstLayout

    Provider.of<MovieRepo>(context, listen: false).lodingall();
    await Provider.of<MovieRepo>(context, listen: false)
        .getboxoffice(context: context, fitstrequst: true, page: 1);
    await Provider.of<MovieRepo>(context, listen: false)
        .getrecentlyadded(context: context, fitstrequst: true, page: 1);
    // Provider.of<MovieRepo>(context, listen: false)
    //     .getexclusive(context: context, fitstrequst: true, page: 1);
    await Provider.of<MovieRepo>(context, listen: false)
        .getrecentlyaddedserise(context: context, fitstrequst: true, page: 1);
    await Provider.of<MovieRepo>(context, listen: false).getsliderimg(context);
    await Provider.of<MovieRepo>(context, listen: false)
        .getcatagory(context: context);
    await Provider.of<MovieRepo>(context, listen: false)
        .getlanguges(context: context);
    Provider.of<MovieRepo>(context, listen: false).falselodingall();
  }
}
