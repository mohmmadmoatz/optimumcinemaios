class Subservice {
  int id;
  String title;
  String price;
  String image;
  String serviceId;
  bool isselcted;

  Subservice({
    this.id,
    this.title,
    this.price,
    this.image,
    this.isselcted,
    this.serviceId,
  });

  Subservice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
    isselcted = false;
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = this.image;
    data['service_id'] = this.serviceId;
    return data;
  }

  Subservice.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'] ?? "";
    price = map['price'] ?? "";
    image = map['image'] ?? "";
    serviceId = map['service_id'] ?? "";
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'service_id': serviceId,
    };
    return map;
  }
}

class SubserviceList {
  final List<Subservice> catagory;
  SubserviceList(this.catagory);

  SubserviceList.fromJson(List<dynamic> dJson)
      : catagory = dJson.map((data) => Subservice.fromJson(data)).toList();
}
