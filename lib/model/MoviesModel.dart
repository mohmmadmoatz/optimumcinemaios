class Moviemodal {
  String id;
  String name;
  String moviecat;
  String year;
  String views;
  String poster;
  String rate;
  String desc;
  String url;
  String vvt;
  String trailer;
  String type;
  String usefor;
  String actors;
  String director;

  Moviemodal({
    this.id,
    this.views,
    this.actors,
    this.director,
    this.name,
    this.trailer,
    this.year,
    this.vvt,
    this.type,
    this.usefor,
    this.desc,
    this.rate,
    this.poster,
    this.moviecat,
  });

  Map<String, dynamic> toMap({typeofele, savetype}) {
    var map = <String, dynamic>{
      'movieid': id ?? "",
      'actors': actors ?? "",
      'director': director ?? "",
      'name': name ?? "",
      'moviecat': moviecat ?? "",
      'year': year ?? "",
      'poster': poster ?? "",
      'rate': rate ?? "",
      'desc': desc ?? "",
      'url': url ?? "",
      'views': views ?? "0",
      'vvt': vvt ?? "",
      'trailer': trailer ?? "",
      'type': typeofele ?? "",
      'usefor': usefor ?? "",
    };
    return map;
  }

  Moviemodal.fromMap(Map<String, dynamic> map) {
    id = map['movieid'];
    name = map['name'];
    poster = map['poster'];
    url = map['url'];
    moviecat = map['moviecat'];
    year = map['year'];
    desc = map['desc'];
    vvt = map['vvt'];
    trailer = map['trailer'];
    views = map['views'].toString();
    rate = map['rate'];
    type = map['type'];
    usefor = map['usefor'];
  }

  Moviemodal.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'].toString() : json['id'] ?? "";
    name = json['name'] is int ? json['name'].toString() : json['name'] ?? "";
    moviecat = json['moviecat_id'] is int
        ? json['moviecat_id'].toString()
        : json['moviecat_id'] ?? "";
    year = json['year'] is int ? json['year'].toString() : json['year'] ?? "";

    trailer = json['trailer'] ?? "";

    actors = json['actors'] ?? "";
    director = json['director'] ?? "";
    views = json['views'].toString() ?? "0";
    poster = json['poster'] is int
        ? json['poster'].toString()
        : json['poster'] ?? "";
    rate = json['rate'] is int ? json['rate'].toString() : json['rate'] ?? "";
    desc = json['desc'] is int ? json['desc'].toString() : json['desc'] ?? "";
    url = json['url'] is int ? json['url'].toString() : json['url'] ?? "";
    vvt = json['vvt'] is int ? json['vvt'].toString() : json['vvt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['moviecat_id'] = this.moviecat;
    data['year'] = this.year;
    data['views'] = this.views;
    data['poster'] = this.poster;

    return data;
  }
}

class MovieList {
  final List<Moviemodal> moiveee;
  MovieList(this.moiveee);

  MovieList.fromJson(List<dynamic> dJson)
      : moiveee = dJson.map((data) => Moviemodal.fromJson(data)).toList();
}
