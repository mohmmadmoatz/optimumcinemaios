import 'package:cinema_project/model/MoviesModel.dart';

class CollectionModel {
  String id;
  String name;
  List<Moviemodal> movies;

  CollectionModel({
    this.id,
    this.name,
    this.movies,
  });

  CollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'].toString() : json['id'];
    name = json['name'] ?? "";
    movies = MovieList.fromJson(json["movies"]).moiveee;
    print("Xxxxx" + movies[0].name);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}

class CollectionList {
  final List<CollectionModel> catagory;
  CollectionList(this.catagory);

  CollectionList.fromJson(List<dynamic> dJson)
      : catagory = dJson.map((data) => CollectionModel.fromJson(data)).toList();
}
