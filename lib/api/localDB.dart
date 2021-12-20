import 'package:cinema_project/model/MoviesModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'localchannels.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

//type 0 movie
//type 1 series
  _onCreate(Database db, int version) async {
    //print("object");
    await db.execute(
        'CREATE TABLE favmovies (id INTEGER PRIMARY KEY AUTOINCREMENT, movieid TEXT, views TEXT, director TEXT, name TEXT, moviecat TEXT, year TEXT, poster TEXT, rate TEXT, desc TEXT, url TEXT, vvt TEXT, actors TEXT, trailer TEXT,type Text ,usefor Text )');
  }

  Future<Moviemodal> addchannels(
      Moviemodal movietime, savetype, typeofele) async {
    var dbClient = await db;
    await dbClient.insert(
        'favmovies',
        movietime.toMap(
          savetype: savetype,
          typeofele: typeofele,
        ));
    print(movietime);
    return movietime;
  }

  Future<List<Moviemodal>> getrecntlyplayed() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('favmovies', columns: [
      'id',
      'movieid',
      'name',
      'moviecat',
      'year',
      'poster',
      'rate',
      'desc',
      'url',
      'vvt',
      'trailer',
      'type',
      'usefor'
    ]);
    List<Moviemodal> notifys = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        notifys.add(Moviemodal.fromMap(maps[i]));
      }
    }
//print(notifys.length.toString());
//print("reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    return notifys;
  }

//print(notifys.length.toString());
//print("reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

  Future<int> deeltechannels(String musicname) async {
    var dbClient = await db;
    return await dbClient.delete(
      'favmovies',
      where: 'name = ?',
      whereArgs: [musicname],
    );
  }

  chexkisfav(String musicname) async {
    var dbClient = await db;

    var maps = dbClient.query('favmovies',
        columns: ['name'], where: '"name" = ?', whereArgs: [musicname]);
    if (maps != null) {
      print(maps);
      return true;
    }
    return false;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
