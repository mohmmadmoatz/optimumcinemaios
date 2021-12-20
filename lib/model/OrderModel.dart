class Order {
  int id;
  String userId;
  String workerId;
  Null serviceId;
  String subserviceId;
  Null location;
  Null spacetime;
  String numberofservices;
  String totalprice;

  Order(
      {this.id,
      this.userId,
      this.workerId,
      this.serviceId,
      this.subserviceId,
      this.location,
      this.spacetime,
      this.numberofservices,
      this.totalprice});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    workerId = json['worker_id'];
    serviceId = json['service_id'];
    subserviceId = json['subservice_id'];
    location = json['location'];
    spacetime = json['spacetime'];
    numberofservices = json['numberofservices'];
    totalprice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['worker_id'] = this.workerId;
    data['service_id'] = this.serviceId;
    data['subservice_id'] = this.subserviceId;
    data['location'] = this.location;
    data['spacetime'] = this.spacetime;
    data['numberofservices'] = this.numberofservices;
    data['totalprice'] = this.totalprice;
    return data;
  }
}
