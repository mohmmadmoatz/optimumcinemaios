import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadApi with ChangeNotifier {
  List<DownloadTask> inDownload = [];
  List<DownloadTask> completed = [];
  int progress = 0;
  var status;
  incrementProgress(p) async {
    progress = p;
    getdownloads();
    notifyListeners();
    if (p == 100) {
      await Future.delayed(Duration(seconds: 1));
      getdownloads();
      getcompleted();
      notifyListeners();
    }
  }

  checkdownloadname(name) {
    var idx = inDownload.indexWhere((item) => item.filename == name);
    if (idx > -1) return true;
    return false;
  }

  getdownloads() async {
    inDownload = await FlutterDownloader.loadTasksWithRawQuery(
        query: "SELECT * FROM task WHERE status=2  or status=6");

    notifyListeners();
  }

  getcompleted() async {
    completed = await FlutterDownloader.loadTasksWithRawQuery(
        query: "SELECT * FROM task WHERE status=3");

    print(completed);
    notifyListeners();
  }

  queueDownload({
    name,
    url,
  }) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(
        url: "$url",
        savedDir: externalDir.path,
        fileName: "$name",
        showNotification: true,
        openFileFromNotification: true,
      );

      print("downloadCompleted : $id");
    } else {
      print("no permission");
    }
  }
}
