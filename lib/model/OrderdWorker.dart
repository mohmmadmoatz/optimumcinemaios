class OrderedWorker {
  int id;
  String name;
  String img;
  String rate;
  String subservicesId;
  String serviceId;
  String isactive;
  bool isselcted;

  OrderedWorker(
      {this.id,
      this.name,
      this.isselcted,
      this.img,
      this.rate,
      this.subservicesId,
      this.serviceId,
      this.isactive});

  OrderedWorker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    rate = json['rate'];
    subservicesId = json['subservices_id'];
    serviceId = json['service_id'];
    isactive = json['isactive'];
    isselcted = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['rate'] = this.rate;
    data['subservices_id'] = this.subservicesId;
    data['service_id'] = this.serviceId;
    data['isactive'] = this.isactive;
    return data;
  }
}

class OrderdWorkerList {
  final List<OrderedWorker> catagory;
  OrderdWorkerList(this.catagory);

  OrderdWorkerList.fromJson(List<dynamic> dJson)
      : catagory = dJson.map((data) => OrderedWorker.fromJson(data)).toList();
}
