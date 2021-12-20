import 'package:cinema_project/constant.dart/diohelpe.dart';
import 'package:cinema_project/constant.dart/serverapi.dart';
import 'package:cinema_project/model/OrderdWorker.dart';
import 'package:cinema_project/model/subservicemodal.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:toast/toast.dart';
import 'package:dio/dio.dart' as dio;

class ServiceRepo with ChangeNotifier {
  //1.get subservices
  bool lodingsubclasses = false;
  String serviceid;
  List<Subservice> subservice = [];
  getsubservices(context, id) {
    serviceid = id;
    subservice.clear();
    lodingsubclasses = true;
    notifyListeners();
    getdata(context: context, name: "subservice/" + id).then((value) {
      subservice.addAll(SubserviceList.fromJson(value).catagory);
      lodingsubclasses = false;
      notifyListeners();
    });
  }

//2.select some subservicess

  selectsubservicess(index) {
    subservice[index].isselcted = !subservice[index].isselcted;
    notifyListeners();
  }

//3. pick time and select number of servicess
  String timetostart = "";
  String timetoend = "";
  String numberofservecr = "";
  picktimeandnumber(timetostartt, timetofinish, number, loc) {
    timetostart = timetostartt;
    timetoend = timetofinish;
    numberofservecr = number;
  }

//get workers connectd to servicee
  bool lodingworkers = false;
  List<OrderedWorker> workers = [];
  getworkers(
    context,
  ) async {
    workers.clear();
    String subservicesids = "";

    for (var i = 0; i < subservice.length; i++) {
      if (subservice[i].isselcted) {
        subservicesids += subservice[i].id.toString() + ",";
      }
    }
//get workers for current job
    lodingworkers = true;
    notifyListeners();
    getuserrsforsubservices(
            context: context,
            name: "subservicesusers/" + serviceid,
            data: subservicesids.substring(0, subservicesids.length - 1))
        .then((value) {
      if (value == null) {
        lodingworkers = false;
        notifyListeners();
        return;
      }
      print(value);
      workers.addAll(OrderdWorkerList.fromJson(value).catagory);
      lodingworkers = false;
      notifyListeners();
    });
  }

  selectworker(name) {
    for (var item in workers) {
      if (item.name == name) {
        item.isselcted = true;
      } else {
        item.isselcted = false;
      }
    }

    notifyListeners();
  }

  /*
  List<Channels> trendchannels = [];
  List<Channels> topchannels = [];
  List<Channels> recentlywatched = [];
  List<Channels> favchannels = [];
  List<Channels> searchchannels = [];
  TabController tabController;
  PageController carouselController;
  int taplenth = 0;
  bool lodingcats = true;
  List<Catagory> barcats = [];
  List<Catagory> homecats = [];

  checkforfav(int index, bool isnottop, bool isbar) {
    if (isnottop) {
      for (var i = 0; i < topchannels.length; i++) {
        for (var x = 0; x < favchannels.length; x++) {
          if (topchannels[i].name == favchannels[x].name) {
            topchannels[i].isfav = true;
          }
        }
      }
    } else {
      if (isbar) {
        for (var i = 0; i < barcats[index].chaneels.length; i++) {
          for (var x = 0; x < favchannels.length; x++) {
            if (barcats[index].chaneels[i].name == favchannels[x].name) {
              barcats[index].chaneels[i].isfav = true;
            }
          }
        }
        notifyListeners();
      } else {
        for (var i = 0; i < homecats[index].chaneels.length; i++) {
          for (var x = 0; x < favchannels.length; x++) {
            if (homecats[index].chaneels[i].name == favchannels[x].name) {
              homecats[index].chaneels[i].isfav = true;
            }
          }
        }
      }
    }

    notifyListeners();
  }

  getcatsbar({context}) async {
    barcats.clear();
    try {
      final res = await DioHelper.getDio().get("$server/tvcatbar",
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
      barcats.addAll(CatagoryList.fromJson(tempdata).catagory);

      taplenth = barcats.length;
      //    getsubcats(id: 0);

      notifyListeners();
    } catch (e) {
      notifyListeners();
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
    }
  }

  getcatshome({context}) async {
    homecats.clear();
    try {
      final res = await DioHelper.getDio().get("$server/tvcathome",
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
      homecats.addAll(CatagoryList.fromJson(tempdata).catagory);
      for (var i = 0; i < homecats.length; i++) {
        await gethomesubcats(context: context, id: homecats[i].id, index: i);
      }
      taplenth = barcats.length;
      //    getsubcats(id: 0);

      notifyListeners();
    } catch (e) {
      notifyListeners();
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
    }
  }

  bool lodingsubcut = false;
  Future getbarsubcats({context, m}) async {
    int x = m - 1;

    if (barcats[x].chaneels != null) {
      checkforfav(x, false, true);

      return;
    }
    lodingsubcut = true;
    notifyListeners();
    try {
      final res =
          await DioHelper.getDio().get("$server/catchannels/" + barcats[x].id,
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
      barcats[x].chaneels = ChannelsListt.fromJson(tempdata).catagory;
      checkforfav(x, false, true);
      lodingsubcut = false;
      notifyListeners();
    } catch (e) {
      //  Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
      notifyListeners();
    }
  }

  bool lodingsearch = false;
  Future getsearch({context, name}) async {
    if (name == "") {
      return;
    }
    lodingsearch = true;
    notifyListeners();
    if (searchchannels.length != 0) {
      searchchannels.clear();
    }
    try {
      final res = await DioHelper.getDio().get("$server/channelssearch/" + name,
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

      searchchannels.addAll(ChannelsListt.fromJson(tempdata).catagory);
      lodingsearch = false;

      notifyListeners();
    } catch (e) {
      //  Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
      notifyListeners();
    }
  }

  Future gethomesubcats({id, context, index}) async {
    try {
      final res = await DioHelper.getDio().get("$server/catchannels/$id",
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
      homecats[index].chaneels = ChannelsListt.fromJson(tempdata).catagory;
      checkforfav(index, false, false);

      notifyListeners();
    } catch (e) {
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
      notifyListeners();
    }
  }

  Future gettrendchannels(context) async {
    try {
      final res = await DioHelper.getDio().get("$server/channelstrend",
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
      trendchannels.addAll(ChannelsListt.fromJson(tempdata).catagory);
      notifyListeners();
    } catch (e) {
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
      notifyListeners();
    }
  }

  bool isrefresh = false;
  Future getopchannels(context) async {
    try {
      final res = await DioHelper.getDio().get("$server/channelsttop",
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
      topchannels.addAll(ChannelsListt.fromJson(tempdata).catagory);
      print(topchannels.length.toString() + "fffffffffffff");
      notifyListeners();
    } catch (e) {
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
      notifyListeners();
    }
  }

  tuenlodingoff() {
    lodingcats = false;
    notifyListeners();
  }

  tuenlodingON() {
    trendchannels.clear();
    topchannels.clear();
    lodingcats = true;
    notifyListeners();
  }

  DBHelper dbHelper;
  getchannels() async {
    recentlywatched.clear();
    dbHelper = DBHelper();
    await dbHelper.getrecntlyplayed().then((onValue) {
      if (onValue.length == 0) {
        notifyListeners();
        return;
      }

      recentlywatched = onValue;
      recentlywatched.sort((a, b) => b.id.compareTo(a.id));
      notifyListeners();
    });
  }

  addtochannels(
    Channels localMusic,
    context,
  ) async {
    if (recentlywatched
        .where((element) => element.name == localMusic.name)
        .isNotEmpty) {
      return;
    } else {
      if (recentlywatched.length == 10) {
        removechannel(recentlywatched.last.name, context);
      }
      dbHelper = DBHelper();
      await dbHelper.addchannels(localMusic);
      getchannels();
      recentlywatched.sort((a, b) => b.id.compareTo(a.id));
      notifyListeners();
    }
  }

  removechannel(channelname, context) {
    dbHelper = DBHelper();
    dbHelper.deeltechannels(channelname);
  }

  getchannelsfav() async {
    favchannels.clear();
    dbHelper = DBHelper();
    await dbHelper.getfavyplayed().then((onValue) {
      if (onValue.length == 0) {
        notifyListeners();
        return;
      }

      favchannels = onValue;
      favchannels.sort((a, b) => b.id.compareTo(a.id));

      notifyListeners();
    });
  }

  addtochannelsfav(
    Channels localMusic,
    context,
    catindex,
    channelindex,
    iscatbar,
  ) async {
    if (favchannels
        .where((element) => element.name == localMusic.name)
        .isNotEmpty) {
      return;
    } else {
      dbHelper = DBHelper();
      if (iscatbar == 0) {
        barcats[catindex].chaneels[channelindex].isfav = true;
      } else if (iscatbar == 1) {
        homecats[catindex].chaneels[channelindex].isfav = true;
      } else if (iscatbar == 2) {
        topchannels[channelindex].isfav = true;
        notifyListeners();
      }

      await dbHelper.addchannelsfav(localMusic);

      getchannelsfav();
      favchannels.sort((a, b) => b.id.compareTo(a.id));
      notifyListeners();
    }
  }

  removechannelfav({channelname, context, catindex, channelindex, iscatbar}) {
    dbHelper = DBHelper();
    dbHelper.deeltechannelsfav(channelname);
    if (iscatbar == 0) {
      barcats[catindex].chaneels[channelindex].isfav = false;
    } else if (iscatbar == 1) {
      homecats[catindex].chaneels[channelindex].isfav = false;
    } else if (iscatbar == 2) {
      topchannels[channelindex].isfav = false;
    }

    notifyListeners();
    getchannelsfav();
  }

  String istv = "";
  getsetting() async {
    final response = await http.get("$server/setting", headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    final int statusCode = response.statusCode;

    print(response.body);
    var datadecode = json.decode(response.body);

    istv = datadecode["data"][0]["val"];
    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }
    return istv;
    notifyListeners();
  }
  */

  Future getdata({
    context,
    name,
  }) async {
    try {
      final res = await DioHelper.getDio().get("$server/" + name,
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
      return tempdata;
    } catch (e) {
      print(e);
    }
  }

  getuserrsforsubservices({context, name, data}) async {
    try {
      final res = await DioHelper.getDio().get("$server/$name/$data",
          options: buildCacheOptions(
            Duration(days: 2),
            forceRefresh: true,
            maxStale: Duration(days: 2),
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
                //"Authorization":"Bearer ${Provider.of<UserRepo>(context, listen: false).loggeduser.token}",
              },
            ),
          ));
      var tempdata = (res.data['data']);
      return tempdata;
    } catch (e) {
      Toast.show("نأسف جدا حدث خطأ ما ", context, duration: 2);
    }
  }
}
