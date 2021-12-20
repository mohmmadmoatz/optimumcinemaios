import 'dart:async';
import 'dart:convert';

import 'package:cinema_project/api/localDB.dart';
import 'package:cinema_project/constant.dart/diohelpe.dart';
import 'package:cinema_project/constant.dart/serverapi.dart';
import 'package:cinema_project/main.dart';
import 'package:cinema_project/model/Catmodel.dart';
import 'package:cinema_project/model/CollectionModel.dart';
import 'package:cinema_project/model/MoviesModel.dart';
import 'package:cinema_project/model/SeriseModal.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as dio;

class MovieRepo with ChangeNotifier {
  chekping() async {
    try {
      print("xxx");
      var url =
          "http://10.24.24.206/optimumcinema/public/api/movies/newadd?page=1";
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      iphone = false;
      server = "http://10.24.24.206/optimumcinema/public";
      notifyListeners();
    } catch (e) {
      print("xxxxx");
      iphone = true;
      notifyListeners();
    }
  }

  bool hasmore = true;
  String epsodchoose = "";
  String seriesurl = "";
  String seriesvvt = "";
  List<Moviemodal> boxoffice = [];
  List<Moviemodal> boxofficecat = [];
  bool loadingboxoffice = false;
  lodingall() {
    loadingboxoffice = true;
    loadingexclusive = true;
    loadingcat = true;
    lodaingsliderimg = true;
    loadingrecentlyaddedserise = true;
    lodingchoosedforyou = true;
    notifyListeners();
  }

  falselodingall() {
    loadingboxoffice = false;
    loadingexclusive = false;
    loadingcat = false;
    lodaingsliderimg = false;
    loadingrecentlyaddedserise = false;
    lodingchoosedforyou = false;
    notifyListeners();
  }

  changeepsodechoose(name, seriesurll, vvt) {
    seriesvvt = vvt;
    epsodchoose = name;
    seriesurl = seriesurll;
    print(epsodchoose);
    notifyListeners();
  }

  List<CollectionModel> collectionlist = [];
  bool loadingcollectionlist = false;
  bool hasmoercollectionlist = false;
  getcollectionlist({context, page, bool fitstrequst}) async {
    hasmoercollectionlist = true;
    notifyListeners();
    var url = "$server/api/getcollections?page=$page";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      ////print("objectdfsfsf");

      if (res.statusCode > 200) {
        loadingcollectionlist = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      print(tempdata);
      if (tempdata["data"].length == 0) {
        hasmoercollectionlist = false;
      }

      if (page != 1) {
        collectionlist
            .addAll(CollectionList.fromJson(tempdata["data"]).catagory);
      } else {
        if (collectionlist.length == 0) {
          collectionlist
              .addAll(CollectionList.fromJson(tempdata["data"]).catagory);
        }
        collectionlist.clear();

        collectionlist
            .addAll(CollectionList.fromJson(tempdata["data"]).catagory);

        collectionlist.shuffle();
      }

      loadingcollectionlist = false;
      notifyListeners();
    } catch (e) {
      loadingcollectionlist = false;
      notifyListeners();
      ////print(e);
    }
  }

  getboxoffice({context, page, bool fitstrequst}) async {
    var url = "$server/api/movies/boxoffice?page=$page";

    hasmore = true;
    notifyListeners();
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      if (res.statusCode > 200) {
        loadingboxoffice = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      var data = tempdata["data"];
      if (tempdata['data'].length == 0) {
        hasmore = false;
      }

      if (page != 1) {
        boxofficecat.addAll(MovieList.fromJson(data).moiveee);
        ////print("boxoffice");
      } else {
        if (boxoffice.length == 0) {
          boxoffice.addAll(MovieList.fromJson(data).moiveee);
        }
        boxofficecat.clear();
        boxofficecat.addAll(MovieList.fromJson(data).moiveee);
        boxoffice.shuffle();
        ////print(boxoffice[0].poster);
      }
      ////print(boxoffice[0].name);
      loadingboxoffice = false;
      notifyListeners();
    } catch (e) {
      ////print(e);
    }
  }

  List<Moviemodal> exclusive = [];
  List<Moviemodal> exclusivecat = [];
  bool loadingexclusive = false;

  getexclusive({context, page, bool fitstrequst}) async {
    var url = "$server/api/movies/getrecentmovies?page=$page";
    hasmore = true;
    notifyListeners();
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      if (res.statusCode > 200) {
        loadingexclusive = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      if (tempdata["data"].length == 0) {
        hasmore = false;
      }

      if (page != 1) {
        exclusivecat.addAll(MovieList.fromJson(tempdata["data"]).moiveee);
      } else {
        if (exclusive.length == 0) {
          exclusive.addAll(MovieList.fromJson(tempdata["data"]).moiveee);
        }
        exclusivecat.clear();

        exclusivecat.addAll(MovieList.fromJson(tempdata["data"]).moiveee);

        exclusive.shuffle();
      }
      print(exclusive.length);
      loadingexclusive = false;
      notifyListeners();
    } catch (e) {
      ////print(e);
    }
  }

  List<Moviemodal> recentlyadded = [];
  List<Moviemodal> recentlyaddedcat = [];
  bool loadingrecentlyadded = false;

  getrecentlyadded({context, page, bool fitstrequst}) async {
    hasmore = true;
    notifyListeners();
    var url = "$server/api/movies/newadd?page=$page";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      ////print("objectdfsfsf");

      if (res.statusCode > 200) {
        loadingrecentlyadded = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      ////print(tempdata);
      if (tempdata["data"].length == 0) {
        hasmore = false;
      }
      print(hasmore.toString());

      if (page != 1) {
        recentlyaddedcat.addAll(MovieList.fromJson(tempdata["data"]).moiveee);
        print("boxoffice");
      } else {
        if (recentlyadded.length == 0) {
          recentlyadded.addAll(MovieList.fromJson(tempdata["data"]).moiveee);
        }
        recentlyaddedcat.clear();

        recentlyaddedcat.addAll(MovieList.fromJson(tempdata["data"]).moiveee);

        recentlyadded.shuffle();
      }

      loadingrecentlyadded = false;
      notifyListeners();
    } catch (e) {
      loadingrecentlyadded = false;
      notifyListeners();
      ////print(e);
    }
  }

  bool hasmorecat = true;
  bool loadingcat = false;
  List<CatagoryModel> catagory = [];
  getcatagory({context}) async {
    loadingcat = true;
    notifyListeners();

    var url = "$server/api/moviecat";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));

      if (res.statusCode > 200) {
        loadingrecentlyadded = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      ////print(tempdata);
      catagory.addAll(CatagoryList.fromJson(tempdata).catagory);
      catagory.shuffle();

      loadingcat = false;
      notifyListeners();
    } catch (e) {
      loadingcat = false;

      notifyListeners();
      ////print(e);
    }
  }

  List languges = [
    {"id": "0", "name": "الكل", "created_at": "333", "updated_at": "00"}
  ];
  List<String> onlylang = [];
  getlanguges({context}) async {
    var url = "$server/api/language";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));

      if (res.statusCode > 200) {
        ////print("error");
      }
      var tempdata = (res.data['data']);
      print(tempdata);
      for (var item in tempdata) {
        languges.add((item));
      }
      for (var item in languges) {
        onlylang.add(item["name"]);
      }
      notifyListeners();
    } catch (e) {
      ////print(e);
    }
  }

  List<Moviemodal> langugecatagorymovies = [];
  bool lodingcatagorymovies = false;
  bool hasmorecatmovie = true;

  getcatagorymovies({context, page, id, langid}) async {
    String langidd = languges[langid]["id"].toString();
    ////print(langidd);
    ////print(id + "jkklhlkhhjkhkjhljkhlkhlkh");
    ////print(langid.toString() + "this is lang is");
    if (page == 1) {
      hasmorecatmovie = true;
      langugecatagorymovies.clear();
      notifyListeners();
    }

    var url;

    if (langidd == "0") {
      ////print('object');
      url = "$server/api/moviecat/$id/movies?page=$page";
    } else {
      ////print("fdsfsdfdsf");
      url = "$server/api/moviecat/$id/movies/$langidd?page=$page";
    }

    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      ////print("objectdfsfsf");

      if (res.statusCode > 200) {
        loadingrecentlyadded = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      ////print(tempdata);
      if (tempdata["data"].length == 0) {
        hasmorecatmovie = false;
      }

      if (page != 1) {
        langugecatagorymovies
            .addAll(MovieList.fromJson(tempdata["data"]).moiveee);
        ////print("boxoffice");
      } else {
        if (recentlyadded.length == 0) {
          langugecatagorymovies
              .addAll(MovieList.fromJson(tempdata["data"]).moiveee);
        }
        langugecatagorymovies.clear();

        langugecatagorymovies
            .addAll(MovieList.fromJson(tempdata["data"]).moiveee);

        langugecatagorymovies.shuffle();
      }

      lodingcatagorymovies = false;
      notifyListeners();
    } catch (e) {
      lodingcatagorymovies = false;
      notifyListeners();
      ////print(e);
    }
  }

  String catofmovie(Moviemodal moviemodal) {
    ////print("object");
    var cats = [];
    var sb = StringBuffer();
    ////print(moviemodal.moviecat);
    String thenames;
    if (moviemodal.moviecat.contains(",")) {
      cats.addAll(moviemodal.moviecat.split(","));
      ////print(cats);
    } else {
      cats.add(moviemodal.moviecat);
    }
    for (var i = 0; i < catagory.length; i++) {
      ////print(catagory[i].id);
      for (var d = 0; d < cats.length; d++) {
        if (catagory[i].id == cats[d]) {
          sb.write(catagory[i].name + ",");
        }
      }
      thenames = sb.toString();
      ////print(thenames);
    }
    return thenames;
  }

  String nameofcats(catss) {
    ////print("object");
    var cats = [];
    var sb = StringBuffer();
    ////print(moviemodal.moviecat);
    String thenames;
    if (catss.contains(",")) {
      cats.addAll(catss.split(","));
      ////print(cats);
    } else {
      cats.add(catss);
    }
    for (var i = 0; i < catagory.length; i++) {
      ////print(catagory[i].id);
      for (var d = 0; d < cats.length; d++) {
        if (catagory[i].id == cats[d]) {
          sb.write(catagory[i].name + ",");
        }
      }
      thenames = sb.toString();
      ////print(thenames);
    }
    return thenames;
  }

  List<Moviemodal> raltedtomovie = [];

  bool raltedtomovielooding = false;
  getrelatedtomovie({context, id}) async {
    ////print(id);

    raltedtomovie.clear();
    raltedtomovielooding = true;
    notifyListeners();

    var url = "$server/api/movieget/$id";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      if (res.statusCode > 200) {
        raltedtomovielooding = false;
        notifyListeners();
      }
      var tempdata = (res.data['relatives']);

      raltedtomovie.addAll(MovieList.fromJson(tempdata).moiveee);
      raltedtomovie.shuffle();

      ////print(raltedtomovie[0].name);
      raltedtomovielooding = false;
      notifyListeners();
    } catch (e) {
      ////print(e);
    }
  }

//http://almadar.your-gs.com/api/movies/3

  bool hasmoresearch = true;
  String thesearch;
  List<SeriseModal> searchseaise = [];
  bool lodingsearch = false;
  int pagge = 1;
  search(
    String search,
  ) async {
    loademoremovies.clear();
    searchseaise.clear();
    hasmoresearch = true;
    lodingsearch = true;
    notifyListeners();

    thesearch = search;

    pagge = 1;

    var url = "$server/api/movies/search/$thesearch?page=$pagge";

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']["data"]);
    var tempdata2 = (res.data['dataserise']["data"]);
    loademoremovies.addAll(MovieList.fromJson(tempdata).moiveee);
    searchseaise.addAll(SeriseList.fromJson(tempdata2).moiveee);
    lodingsearch = false;

    notifyListeners();
  }

  List<Moviemodal> loademoremovies = [];

  getmoredata(page) async {
    if (page == 1) {
      loademoremovies.clear();
      searchseaise.clear();
    }

    var url = "$server/api/movies/search/$thesearch?page=" + page.toString();

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']["data"]);
    var tempdata2 = (res.data['dataserise']["data"]);
    if (tempdata.length == 0 && tempdata2.length == 0) {
      hasmoresearch = false;

      notifyListeners();
    } else {
      loademoremovies.addAll(MovieList.fromJson(tempdata).moiveee);
      searchseaise.addAll(SeriseList.fromJson(tempdata2).moiveee);

      notifyListeners();
    }
  }

  var markersdata = [];
  getmapdata() async {
    markersdata = [];
    try {
      var url =
          "http://manager.almadarisp.com/api_info.php?key=FS9192FS&operation=Maps";

      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));

      var tempdata = (res.data);
      markersdata.addAll(jsonDecode(tempdata));
      ////print(markersdata);
      ////print(markersdata);
      ////print(markersdata);
      ////print(markersdata);
      notifyListeners();
    } catch (e) {}
  }

  List<Moviemodal> choosedforyou = [];
  bool lodingchoosedforyou = false;
  getchoosedforyou(context) async {
    lodingchoosedforyou = true;
    notifyListeners();
    var url = "$server/api/movies/random";

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']);

    choosedforyou.addAll(MovieList.fromJson(tempdata).moiveee);
    lodingchoosedforyou = false;
    notifyListeners();
  }

  var sliderimg = [];
  bool lodaingsliderimg = false;

  getsliderimg(context) async {
    sliderimg.clear();
    var url = "$server/api/slideshow";

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']);

    sliderimg.addAll(tempdata);
    lodaingsliderimg = false;
    notifyListeners();
  }

  List<SeriseModal> recentlyaddedserise = [];
  List<SeriseModal> recentlyaddedcatserise = [];
  bool loadingrecentlyaddedserise = false;

  getrecentlyaddedserise({context, page, bool fitstrequst}) async {
    hasmore = true;
    notifyListeners();
    var url = "$server/api/series/newadd?page=$page";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      ////print("objectdfsfsf");

      if (res.statusCode > 200) {
        loadingrecentlyadded = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      ////print(tempdata);
      if (tempdata["data"].length == 0) {
        hasmore = false;
      }
      print(hasmore.toString());

      if (page != 1) {
        recentlyaddedcatserise
            .addAll(SeriseList.fromJson(tempdata["data"]).moiveee);
        print("boxoffice");
      } else {
        if (recentlyadded.length == 0) {
          recentlyaddedserise
              .addAll(SeriseList.fromJson(tempdata["data"]).moiveee);
        }
        recentlyaddedcatserise.clear();

        recentlyaddedcatserise
            .addAll(SeriseList.fromJson(tempdata["data"]).moiveee);

        recentlyaddedcatserise.shuffle();
      }

      loadingrecentlyaddedserise = false;
      notifyListeners();
    } catch (e) {
      loadingrecentlyaddedserise = false;
      notifyListeners();
      ////print(e);
    }
  }

  List<SeriseModal> catagoryseries = [];
  bool loadingcatagoryseries = false;
  bool hasmorecatseries = false;

  getseriescatagory({context, page, catid}) async {
    if (page == 1) {
      hasmorecatseries = true;
      loadingcatagoryseries = true;
      catagoryseries.clear();
      notifyListeners();
    }

    var url = "$server/api/series?catid=$catid&page=$page";
    try {
      final res = await DioHelper.getDio().get(url,
          options: buildCacheOptions(
            Duration(days: 2),
            maxStale: Duration(days: 1),
            forceRefresh: true,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          ));
      ////print("objectdfsfsf");

      if (res.statusCode > 200) {
        loadingrecentlyadded = false;
        notifyListeners();
      }
      var tempdata = (res.data['data']);
      ////print(tempdata);
      if (tempdata["data"].length == 0) {
        hasmorecatseries = false;
      }
      print(hasmore.toString());

      if (page != 1) {
        catagoryseries.addAll(SeriseList.fromJson(tempdata["data"]).moiveee);
        print("boxoffice");
      } else {
        if (recentlyadded.length == 0) {
          recentlyaddedserise
              .addAll(SeriseList.fromJson(tempdata["data"]).moiveee);
        }
        catagoryseries.clear();

        catagoryseries.addAll(SeriseList.fromJson(tempdata["data"]).moiveee);

        catagoryseries.shuffle();
      }

      loadingcatagoryseries = false;
      notifyListeners();
    } catch (e) {
      loadingcatagoryseries = false;
      notifyListeners();
      ////print(e);
    }
  }

  List seriesseonsepsods = [];
  bool seriesseonsepsiodsloding = false;

  getseriesepsods(context, id) async {
    seriesseonsepsods.clear();
    seriesseonsepsiodsloding = true;
    notifyListeners();
    var url = "$server/api/series/season/$id";

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']);
    for (var i = 0; i < tempdata.length; i++) {
      seriesseonsepsods.add(tempdata[i]);
    }
    print(seriesseonsepsods[0]);
    // choosedforyou.addAll(MovieList.fromJson(tempdata).moiveee);
    seriesseonsepsiodsloding = false;
    notifyListeners();
  }

  var sesons = [];
  bool lodingsesoms = false;
  getsesons(context, id) async {
    sesons.clear();
    lodingsesoms = true;
    notifyListeners();
    var url = "$server/api/series_s/get/$id";

    final res = await DioHelper.getDio().get(url,
        options: buildCacheOptions(
          Duration(days: 2),
          maxStale: Duration(days: 1),
          forceRefresh: true,
          options: dio.Options(
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ));

    var tempdata = (res.data['data']);
    for (var i = 0; i < tempdata.length; i++) {
      sesons.add(tempdata[i]);
      sesons[i]["ischecked"] = false;
    }
    sesons[0]["ischecked"] = true;

    getseriesepsods(context, sesons[0]["id"]);
    // choosedforyou.addAll(MovieList.fromJson(tempdata).moiveee);
    lodingsesoms = false;
    notifyListeners();
  }

  chooseseson(context, ii) {
    getseriesepsods(context, sesons[ii]["id"]);
    for (var i = 0; i < sesons.length; i++) {
      sesons[i]["ischecked"] = false;
    }
    sesons[ii]["ischecked"] = true;
    notifyListeners();
  }

  List<Moviemodal> faveroite = [];
  DBHelper dbHelper;
  getfav() async {
    faveroite.clear();
    dbHelper = DBHelper();
    await dbHelper.getrecntlyplayed().then((onValue) {
      if (onValue.length == 0) {
        notifyListeners();
        return;
      }

      faveroite = onValue;
      faveroite.sort((a, b) => b.id.compareTo(a.id));
      print(faveroite);
      notifyListeners();
    });
  }

  removeformlocaldb(channelname, context) {
    dbHelper = DBHelper();
    dbHelper.deeltechannels(channelname);
  }

  addtochannelsfav(
    Moviemodal localMusic,
    context,
  ) async {
    if (faveroite
        .where((element) => element.name == localMusic.name)
        .isNotEmpty) {
      return;
    } else {
      dbHelper = DBHelper();

      await dbHelper.addchannels(localMusic, "", "");

      getfav();
      faveroite.sort((a, b) => b.id.compareTo(a.id));
      notifyListeners();
    }
  }

  checkisfav(name) {}

  List<String> comments = [];
  bool lodingcomments = false;
  svaecomment(id, name) async {
    comments.clear();
    lodingcomments = true;
    notifyListeners();
    var url = "$server/api/comment";

    final res = await DioHelper.getDio().post(
      url,
      data: {
        "name": name,
        "movie_id": id,
      },
    );
    getcomments(id);
    lodingcomments = false;
    notifyListeners();
  }

  getcomments(id) async {
    var url = "$server/api/comment/$id";
    comments.clear();
    final res = await DioHelper.getDio().get(
      url,
    );
    var tempdata = (res.data['data']);
    for (var i = 0; i < tempdata.length; i++) {
      comments.add(tempdata[i]["name"]);
    }
    notifyListeners();
  }
}
