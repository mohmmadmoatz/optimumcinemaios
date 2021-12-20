class CatagoryModel {
  String id;
  String name;
  String poster;

  CatagoryModel({this.id, this.name, this.poster});

  CatagoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'].toString() : json['id'];
    name = json['name'] ?? "";
    poster = json['poster'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster'] = this.poster;

    return data;
  }
}

class CatagoryList {
  final List<CatagoryModel> catagory;
  CatagoryList(this.catagory);

  CatagoryList.fromJson(List<dynamic> dJson)
      : catagory = dJson.map((data) => CatagoryModel.fromJson(data)).toList();
}
