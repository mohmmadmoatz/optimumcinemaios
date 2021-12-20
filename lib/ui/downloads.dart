import 'package:after_layout/after_layout.dart';
import 'package:cinema_project/api/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DownloadsVideos extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<DownloadsVideos> with AfterLayoutMixin {
  List downloadsitems = [];
  int _currentidx = 0;
  @override
  Widget build(BuildContext context) {
    var downloadapi = Provider.of<DownloadApi>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("التحميلات"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            downloadapi.inDownload.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "جاري التحميل ",
                          style: TextStyle(fontSize: 20),
                        )),
                  )
                : Container(),
            downloadapi.inDownload.length > 0
                ? ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (var i = 0; i < downloadapi.inDownload.length; i++)
                        ListTile(
                            onTap: () {},
                            title: Text(downloadapi.inDownload[i].filename),
                            trailing: Text(
                                "${downloadapi.inDownload[i].progress > 0 ? downloadapi.inDownload[i].progress : 0}%"),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        FlutterDownloader.remove(
                                            taskId: downloadapi
                                                .inDownload[i].taskId,
                                            shouldDeleteContent: true);
                                        downloadapi.getdownloads();
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          downloadapi.inDownload[i].status ==
                                                  DownloadTaskStatus.paused
                                              ? Icons.play_arrow
                                              : Icons.pause),
                                      onPressed: () {
                                        if (downloadapi.inDownload[i].status ==
                                            DownloadTaskStatus.paused) {
                                          FlutterDownloader.resume(
                                            taskId: downloadapi
                                                .inDownload[i].taskId,
                                          );
                                        } else {
                                          FlutterDownloader.pause(
                                            taskId: downloadapi
                                                .inDownload[i].taskId,
                                          );
                                        }

                                        downloadapi.getdownloads();
                                      },
                                    ),
                                  ],
                                ),
                                LinearProgressIndicator(
                                    semanticsValue: downloadapi
                                        .inDownload[i].progress
                                        .toString(),
                                    semanticsLabel: "التقدم",
                                    value: downloadapi.inDownload[i].progress /
                                        100),
                              ],
                            ))
                    ],
                  )
                : Container(),
            Column(
              children: [
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    onTap: (idx) {
                      setState(() {
                        _currentidx = idx;
                      });
                    },
                    tabs: [
                      Tab(
                        text: "الافلام",
                      ),
                      Tab(
                        text: "المسلسلات",
                      )
                    ],
                  ),
                ),
                _currentidx == 0
                    ? ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var item in completedMovies)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () async {
                                  FlutterDownloader.open(taskId: item.taskId);
                                },
                                title: Text(item.filename.toString()),
                                leading: Icon(Icons.play_arrow),
                                tileColor: Colors.brown,
                                trailing: IconButton(
                                  onPressed: () async {
                                    FlutterDownloader.remove(
                                        taskId: item.taskId,
                                        shouldDeleteContent: true);
                                    filterDownloads();
                                  },
                                  icon: Icon(Icons.delete_forever),
                                ),
                              ),
                            )
                        ],
                      )
                    : ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          for (var item in groupedSeries)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () async {
                                  Get.bottomSheet(SingleChildScrollView(
                                    child: Container(
                                      color: Theme.of(context).backgroundColor,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "المواسم",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          ListView(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              for (var season
                                                  in item['seasons'])
                                                ListTile(
                                                  title: Text(
                                                      season['seasonName']),
                                                  trailing:
                                                      Icon(Icons.chevron_right),
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        color: Theme.of(context)
                                                            .backgroundColor,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "الحلقات",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            for (var epi
                                                                in season[
                                                                    'epi'])
                                                              ListTile(
                                                                onTap: () {
                                                                  FlutterDownloader.open(
                                                                      taskId: epi[
                                                                          'taskid']);
                                                                },
                                                                title: Text(epi[
                                                                    'epiname']),
                                                                trailing:
                                                                    IconButton(
                                                                  icon: Icon(Icons
                                                                      .delete_forever),
                                                                  onPressed:
                                                                      () {
                                                                    FlutterDownloader.remove(
                                                                        taskId: epi[
                                                                            'taskid'],
                                                                        shouldDeleteContent:
                                                                            true);
                                                                    filterDownloads();
                                                                    Get.back();
                                                                    Get.back();
                                                                  },
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                                },
                                title: Text(item['name']),
                                leading: Icon(Icons.play_arrow),
                                tileColor: Colors.deepOrange,
                              ),
                            )
                        ],
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DownloadTask> completedMovies = [];
  List<DownloadTask> completedSeries = [];
  var groupedSeries = [];

  filterDownloads() async {
    groupedSeries.clear();
    Provider.of<DownloadApi>(context, listen: false).getdownloads();
    await Provider.of<DownloadApi>(context, listen: false).getcompleted();
    setState(() {
      completedMovies.clear();
      completedSeries.clear();

      completedMovies.addAll(Provider.of<DownloadApi>(context, listen: false)
          .completed
          .where((item) => !item.filename.contains("|"))
          .toList());
      completedSeries.addAll(Provider.of<DownloadApi>(context, listen: false)
          .completed
          .where((item) => item.filename.contains("|"))
          .toList());
    });

    for (var item in completedSeries) {
      var seriesName = item.filename.split("|")[0];
      var seasonName = item.filename.split("|")[1];
      var epi = item.filename.split("|")[2];
      var filterByName =
          groupedSeries.indexWhere((x) => x['name'] == seriesName);

      if (filterByName > -1) {
        // assign season and epioside

        var filterBySeason = groupedSeries[filterByName]['seasons']
            .indexWhere((x) => x['seasonName'] == seasonName);
        if (filterBySeason > -1) {
          groupedSeries[filterByName]['seasons'][filterBySeason]['epi']
              .add({"epiname": epi, "taskid": item.taskId});
        } else {
          groupedSeries[filterByName]['seasons'].add({
            "seasonName": seasonName,
            "epi": [
              {"epiname": epi, "taskid": item.taskId}
            ]
          });
        }
      } else {
        groupedSeries.add({
          "name": seriesName,
          "seasons": [
            {
              "seasonName": seasonName,
              "epi": [
                {"epiname": epi, "taskid": item.taskId}
              ]
            }
          ]
        });
      }
    }
    setState(() {
      print("series:$groupedSeries");
    });
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // TODO: implement afterFirstLayout
    // getDownloads();

    filterDownloads();
  }
}
