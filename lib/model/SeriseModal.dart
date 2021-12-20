class SeriseModal {
  int id;
  String name;
  String seriesRate;
  String year;
  String language;
  String seriesDesc;
  String poster;
  String actor;
  String director;
  String seriesCat;

  SeriseModal({
    this.id,
    this.name,
    this.director,
    this.actor,
    this.seriesRate,
    this.year,
    this.language,
    this.seriesDesc,
    this.poster,
    this.seriesCat,
  });

  SeriseModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    director = json['director'];
    actor = json['actor'];
    seriesRate = json['series_rate'];
    year = json['year'];
    language = json['language'];
    seriesDesc = json['series_desc'];
    poster = json['poster'];
    seriesCat = json['series_cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['series_rate'] = this.seriesRate;
    data['year'] = this.year;
    data['language'] = this.language;
    data['series_desc'] = this.seriesDesc;
    data['poster'] = this.poster;
    data['series_cat'] = this.seriesCat;

    return data;
  }
}

class SeriseList {
  final List<SeriseModal> moiveee;
  SeriseList(this.moiveee);

  SeriseList.fromJson(List<dynamic> dJson)
      : moiveee = dJson.map((data) => SeriseModal.fromJson(data)).toList();
}
